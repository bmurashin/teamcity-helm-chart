--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Debian 16.9-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.action_history (
    object_id character varying(80),
    comment_id bigint,
    action integer,
    additional_data character varying(80)
);


ALTER TABLE public.action_history OWNER TO teamcity;

--
-- Name: agent; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    host_addr character varying(80) NOT NULL,
    port integer NOT NULL,
    agent_type_id integer NOT NULL,
    status integer,
    authorized integer,
    registered integer,
    registration_timestamp bigint,
    last_binding_timestamp bigint,
    unregistered_reason character varying(256),
    authorization_token character varying(32),
    status_to_restore integer,
    status_restoring_timestamp bigint,
    version character varying(80),
    plugins_version character varying(80)
);


ALTER TABLE public.agent OWNER TO teamcity;

--
-- Name: agent_pool; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_pool (
    agent_pool_id integer NOT NULL,
    agent_pool_name character varying(191),
    min_agents integer,
    max_agents integer,
    owner_project_id character varying(80)
);


ALTER TABLE public.agent_pool OWNER TO teamcity;

--
-- Name: agent_pool_project; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_pool_project (
    agent_pool_id integer NOT NULL,
    project_int_id character varying(80) NOT NULL
);


ALTER TABLE public.agent_pool_project OWNER TO teamcity;

--
-- Name: agent_type; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type (
    agent_type_id integer NOT NULL,
    agent_pool_id integer NOT NULL,
    cloud_code character varying(6) NOT NULL,
    profile_id character varying(30) NOT NULL,
    image_id character varying(60) NOT NULL,
    policy integer NOT NULL
);


ALTER TABLE public.agent_type OWNER TO teamcity;

--
-- Name: agent_type_bt_access; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type_bt_access (
    agent_type_id integer NOT NULL,
    build_type_id character varying(80) NOT NULL
);


ALTER TABLE public.agent_type_bt_access OWNER TO teamcity;

--
-- Name: agent_type_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type_info (
    agent_type_id integer NOT NULL,
    os_name character varying(60) NOT NULL,
    cpu_rank integer,
    created_timestamp timestamp without time zone,
    modified_timestamp timestamp without time zone
);


ALTER TABLE public.agent_type_info OWNER TO teamcity;

--
-- Name: agent_type_param; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type_param (
    agent_type_id integer NOT NULL,
    param_kind character(1) NOT NULL,
    param_name character varying(160) NOT NULL,
    param_value character varying(2000)
);


ALTER TABLE public.agent_type_param OWNER TO teamcity;

--
-- Name: agent_type_runner; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type_runner (
    agent_type_id integer NOT NULL,
    runner character varying(250) NOT NULL
);


ALTER TABLE public.agent_type_runner OWNER TO teamcity;

--
-- Name: agent_type_vcs; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.agent_type_vcs (
    agent_type_id integer NOT NULL,
    vcs character varying(250) NOT NULL
);


ALTER TABLE public.agent_type_vcs OWNER TO teamcity;

--
-- Name: audit_additional_object; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.audit_additional_object (
    comment_id bigint,
    object_index integer,
    object_id character varying(80),
    object_name character varying(2500)
);


ALTER TABLE public.audit_additional_object OWNER TO teamcity;

--
-- Name: backup_builds; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.backup_builds (
    build_id bigint NOT NULL
);


ALTER TABLE public.backup_builds OWNER TO teamcity;

--
-- Name: backup_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.backup_info (
    mproc_id integer NOT NULL,
    file_name character varying(1000),
    file_size bigint,
    started timestamp without time zone NOT NULL,
    finished timestamp without time zone,
    status character(1)
);


ALTER TABLE public.backup_info OWNER TO teamcity;

--
-- Name: branch_name_dict; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.branch_name_dict (
    id bigint NOT NULL,
    branch_name character varying(2000) NOT NULL,
    branch_name_hash character varying(80) NOT NULL,
    insertion_time bigint NOT NULL
);


ALTER TABLE public.branch_name_dict OWNER TO teamcity;

--
-- Name: build_artifact_dependency; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_artifact_dependency (
    artif_dep_id character varying(40) NOT NULL,
    build_state_id bigint,
    source_build_type_id character varying(80),
    revision_rule character varying(80),
    branch character varying(255),
    src_paths character varying(40960)
);


ALTER TABLE public.build_artifact_dependency OWNER TO teamcity;

--
-- Name: build_attrs; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_attrs (
    build_state_id bigint NOT NULL,
    attr_name character varying(70) NOT NULL,
    attr_value character varying(1000),
    attr_num_value bigint
);


ALTER TABLE public.build_attrs OWNER TO teamcity;

--
-- Name: build_checkout_rules; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_checkout_rules (
    build_state_id bigint NOT NULL,
    vcs_root_id integer NOT NULL,
    checkout_rules character varying(16000)
);


ALTER TABLE public.build_checkout_rules OWNER TO teamcity;

--
-- Name: build_data_storage; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_data_storage (
    build_id bigint NOT NULL,
    metric_id bigint NOT NULL,
    metric_value numeric(19,6) NOT NULL
);


ALTER TABLE public.build_data_storage OWNER TO teamcity;

--
-- Name: build_dependency; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_dependency (
    build_state_id bigint NOT NULL,
    depends_on bigint NOT NULL,
    dependency_options integer
);


ALTER TABLE public.build_dependency OWNER TO teamcity;

--
-- Name: build_labels; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_labels (
    build_id bigint NOT NULL,
    vcs_root_id integer NOT NULL,
    label character varying(80),
    status integer DEFAULT 0,
    error_message character varying(256)
);


ALTER TABLE public.build_labels OWNER TO teamcity;

--
-- Name: build_overriden_roots; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_overriden_roots (
    build_state_id bigint NOT NULL,
    original_vcs_root_id integer NOT NULL,
    substitution_vcs_root_id integer NOT NULL
);


ALTER TABLE public.build_overriden_roots OWNER TO teamcity;

--
-- Name: build_problem; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_problem (
    build_state_id bigint NOT NULL,
    problem_id integer NOT NULL,
    problem_description character varying(4000)
);


ALTER TABLE public.build_problem OWNER TO teamcity;

--
-- Name: build_problem_attribute; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_problem_attribute (
    build_state_id bigint NOT NULL,
    problem_id integer NOT NULL,
    attr_name character varying(60) NOT NULL,
    attr_value character varying(2000) NOT NULL
);


ALTER TABLE public.build_problem_attribute OWNER TO teamcity;

--
-- Name: build_problem_muted; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_problem_muted (
    build_state_id bigint NOT NULL,
    problem_id integer NOT NULL,
    mute_id integer
);


ALTER TABLE public.build_problem_muted OWNER TO teamcity;

--
-- Name: build_project; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_project (
    build_id bigint NOT NULL,
    project_level integer NOT NULL,
    project_int_id character varying(80) NOT NULL
);


ALTER TABLE public.build_project OWNER TO teamcity;

--
-- Name: build_queue; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_queue (
    build_type_id character varying(80),
    agent_restrictor_type_id integer,
    agent_restrictor_id integer,
    requestor character varying(1024),
    build_state_id bigint
);


ALTER TABLE public.build_queue OWNER TO teamcity;

--
-- Name: build_queue_order; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_queue_order (
    version bigint NOT NULL,
    line_num integer NOT NULL,
    promotion_ids character varying(2000)
);


ALTER TABLE public.build_queue_order OWNER TO teamcity;

--
-- Name: build_revisions; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_revisions (
    build_state_id bigint NOT NULL,
    vcs_root_id integer NOT NULL,
    vcs_revision character varying(200) NOT NULL,
    vcs_revision_display_name character varying(200),
    vcs_branch_name character varying(1024),
    modification_id bigint,
    vcs_root_type integer,
    checkout_mode integer
);


ALTER TABLE public.build_revisions OWNER TO teamcity;

--
-- Name: build_set_tmp; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_set_tmp (
    build_id bigint NOT NULL
);


ALTER TABLE public.build_set_tmp OWNER TO teamcity;

--
-- Name: build_state; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_state (
    id bigint NOT NULL,
    build_id bigint,
    build_type_id character varying(80),
    modification_id bigint,
    chain_modification_id bigint,
    personal_modification_id bigint,
    personal_user_id bigint,
    is_personal smallint DEFAULT 0 NOT NULL,
    is_canceled smallint DEFAULT 0 NOT NULL,
    is_changes_detached smallint DEFAULT 0 NOT NULL,
    is_deleted smallint DEFAULT 0 NOT NULL,
    branch_name character varying(1024),
    queued_time bigint,
    remove_from_queue_time bigint
);


ALTER TABLE public.build_state OWNER TO teamcity;

--
-- Name: build_state_private_tag; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_state_private_tag (
    build_state_id bigint NOT NULL,
    owner bigint NOT NULL,
    tag character varying(255) NOT NULL
);


ALTER TABLE public.build_state_private_tag OWNER TO teamcity;

--
-- Name: build_state_tag; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_state_tag (
    build_state_id bigint NOT NULL,
    tag character varying(255) NOT NULL
);


ALTER TABLE public.build_state_tag OWNER TO teamcity;

--
-- Name: build_type; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type (
    int_id character varying(80) NOT NULL,
    config_id character varying(80) NOT NULL,
    origin_project_id character varying(80),
    delete_time bigint
);


ALTER TABLE public.build_type OWNER TO teamcity;

--
-- Name: build_type_counters; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type_counters (
    build_type_id character varying(80) NOT NULL,
    counter bigint NOT NULL
);


ALTER TABLE public.build_type_counters OWNER TO teamcity;

--
-- Name: build_type_edge_relation; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type_edge_relation (
    child_modification_id bigint NOT NULL,
    build_type_id character varying(80) NOT NULL,
    parent_num integer NOT NULL,
    change_type integer
);


ALTER TABLE public.build_type_edge_relation OWNER TO teamcity;

--
-- Name: build_type_group_vcs_change; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type_group_vcs_change (
    modification_id bigint NOT NULL,
    group_id integer NOT NULL,
    change_type integer
);


ALTER TABLE public.build_type_group_vcs_change OWNER TO teamcity;

--
-- Name: build_type_mapping; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type_mapping (
    int_id character varying(80) NOT NULL,
    ext_id character varying(240) NOT NULL,
    main smallint NOT NULL
);


ALTER TABLE public.build_type_mapping OWNER TO teamcity;

--
-- Name: build_type_vcs_change; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.build_type_vcs_change (
    modification_id bigint NOT NULL,
    build_type_id character varying(80) NOT NULL,
    change_type integer
);


ALTER TABLE public.build_type_vcs_change OWNER TO teamcity;

--
-- Name: canceled_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.canceled_info (
    build_id bigint NOT NULL,
    user_id bigint,
    description character varying(256),
    interrupt_type integer
);


ALTER TABLE public.canceled_info OWNER TO teamcity;

--
-- Name: clean_checkout_enforcement; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.clean_checkout_enforcement (
    build_type_id character varying(80) NOT NULL,
    agent_id integer NOT NULL,
    current_build_id bigint NOT NULL,
    request_time timestamp without time zone NOT NULL
);


ALTER TABLE public.clean_checkout_enforcement OWNER TO teamcity;

--
-- Name: cleanup_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cleanup_history (
    proc_id bigint NOT NULL,
    start_time bigint NOT NULL,
    finish_time bigint,
    interrupt_reason character varying(20)
);


ALTER TABLE public.cleanup_history OWNER TO teamcity;

--
-- Name: cloud_image_state; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cloud_image_state (
    project_id character varying(80) NOT NULL,
    profile_id character varying(30) NOT NULL,
    image_id character varying(80) NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.cloud_image_state OWNER TO teamcity;

--
-- Name: cloud_image_without_agent; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cloud_image_without_agent (
    profile_id character varying(30) NOT NULL,
    cloud_code character varying(6) NOT NULL,
    image_id character varying(80) NOT NULL,
    last_update timestamp without time zone NOT NULL
);


ALTER TABLE public.cloud_image_without_agent OWNER TO teamcity;

--
-- Name: cloud_instance_state; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cloud_instance_state (
    project_id character varying(80) NOT NULL,
    profile_id character varying(30) NOT NULL,
    image_id character varying(80) NOT NULL,
    instance_id character varying(80) NOT NULL,
    name character varying(80) NOT NULL,
    last_update timestamp without time zone NOT NULL,
    status character varying(30) NOT NULL,
    start_time timestamp without time zone NOT NULL,
    network_identity character varying(80),
    is_expired smallint,
    agent_id integer
);


ALTER TABLE public.cloud_instance_state OWNER TO teamcity;

--
-- Name: cloud_started_instance; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cloud_started_instance (
    profile_id character varying(30) NOT NULL,
    cloud_code character varying(6) NOT NULL,
    image_id character varying(80) NOT NULL,
    instance_id character varying(80) NOT NULL,
    last_update timestamp without time zone NOT NULL
);


ALTER TABLE public.cloud_started_instance OWNER TO teamcity;

--
-- Name: cloud_state_data; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.cloud_state_data (
    project_id character varying(80) NOT NULL,
    profile_id character varying(30) NOT NULL,
    image_id character varying(80) NOT NULL,
    instance_id character varying(80) NOT NULL,
    data character varying(2000) NOT NULL
);


ALTER TABLE public.cloud_state_data OWNER TO teamcity;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    author_id bigint,
    when_changed bigint NOT NULL,
    commentary character varying(4096)
);


ALTER TABLE public.comments OWNER TO teamcity;

--
-- Name: compiler_output; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.compiler_output (
    build_id bigint,
    message_order integer,
    message character varying(40960)
);


ALTER TABLE public.compiler_output OWNER TO teamcity;

--
-- Name: config_persisting_tasks; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.config_persisting_tasks (
    id bigint NOT NULL,
    task_type character varying(20) NOT NULL,
    description character varying(2000),
    stage integer NOT NULL,
    node_id character varying(80) NOT NULL,
    created bigint NOT NULL,
    updated bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.config_persisting_tasks OWNER TO teamcity;

--
-- Name: custom_data; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.custom_data (
    data_key_hash character varying(80) NOT NULL,
    collision_idx integer NOT NULL,
    data_domain character varying(80) NOT NULL,
    data_key character varying(2000) NOT NULL,
    data_id bigint NOT NULL
);


ALTER TABLE public.custom_data OWNER TO teamcity;

--
-- Name: custom_data_body; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.custom_data_body (
    id bigint NOT NULL,
    part_num integer NOT NULL,
    total_parts integer NOT NULL,
    data_body character varying(2000),
    update_date bigint NOT NULL
);


ALTER TABLE public.custom_data_body OWNER TO teamcity;

--
-- Name: data_storage_dict; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.data_storage_dict (
    metric_id bigint NOT NULL,
    value_type_key character varying(200)
);


ALTER TABLE public.data_storage_dict OWNER TO teamcity;

--
-- Name: db_heartbeat; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.db_heartbeat (
    node_id character varying(80),
    starting_code bigint NOT NULL,
    starting_time timestamp without time zone,
    lock_mode character(1) NOT NULL,
    ip_address character varying(80),
    additional_info character varying(2000),
    last_time timestamp without time zone,
    update_interval bigint,
    uuid character varying(80),
    app_type character varying(80),
    url character varying(128),
    access_token character varying(80),
    build_number character varying(80),
    display_version character varying(80),
    responsibilities bigint,
    unix_last_time bigint,
    unix_starting_time bigint
);


ALTER TABLE public.db_heartbeat OWNER TO teamcity;

--
-- Name: db_version; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.db_version (
    version_number integer NOT NULL,
    version_time timestamp without time zone NOT NULL,
    incompatible_change smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.db_version OWNER TO teamcity;

--
-- Name: default_build_parameters; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.default_build_parameters (
    build_state_id bigint,
    param_name character varying(2000),
    param_value character varying(16000)
);


ALTER TABLE public.default_build_parameters OWNER TO teamcity;

--
-- Name: domain_sequence; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.domain_sequence (
    domain_name character varying(100) NOT NULL,
    last_used_value bigint NOT NULL
);


ALTER TABLE public.domain_sequence OWNER TO teamcity;

--
-- Name: downloaded_artifacts; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.downloaded_artifacts (
    target_build_id bigint,
    source_build_id bigint,
    download_timestamp bigint,
    artifact_path character varying(8192)
);


ALTER TABLE public.downloaded_artifacts OWNER TO teamcity;

--
-- Name: duplicate_diff; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.duplicate_diff (
    build_id bigint NOT NULL,
    hash bigint NOT NULL
);


ALTER TABLE public.duplicate_diff OWNER TO teamcity;

--
-- Name: duplicate_fragments; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.duplicate_fragments (
    id bigint NOT NULL,
    file_id bigint NOT NULL,
    line integer NOT NULL,
    offset_info character varying(100) NOT NULL
);


ALTER TABLE public.duplicate_fragments OWNER TO teamcity;

--
-- Name: duplicate_results; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.duplicate_results (
    id bigint NOT NULL,
    build_id bigint NOT NULL,
    hash integer NOT NULL,
    cost integer
);


ALTER TABLE public.duplicate_results OWNER TO teamcity;

--
-- Name: duplicate_stats; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.duplicate_stats (
    build_id bigint NOT NULL,
    total integer,
    new_total integer,
    old_total integer
);


ALTER TABLE public.duplicate_stats OWNER TO teamcity;

--
-- Name: duplicate_vcs_modification; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.duplicate_vcs_modification (
    modification_id bigint NOT NULL,
    orig_modification_id bigint NOT NULL,
    register_date bigint NOT NULL,
    vcs_root_id integer NOT NULL,
    changes_count integer
);


ALTER TABLE public.duplicate_vcs_modification OWNER TO teamcity;

--
-- Name: failed_tests; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.failed_tests (
    test_name_id bigint NOT NULL,
    build_id bigint NOT NULL,
    test_id integer NOT NULL,
    ffi_build_id bigint
);


ALTER TABLE public.failed_tests OWNER TO teamcity;

--
-- Name: failed_tests_output; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.failed_tests_output (
    build_id bigint NOT NULL,
    test_id integer NOT NULL,
    problem_description character varying(256),
    std_output character varying(40960),
    error_output character varying(40960),
    stacktrace character varying(40960),
    expected character varying(40960),
    actual character varying(40960)
);


ALTER TABLE public.failed_tests_output OWNER TO teamcity;

--
-- Name: final_artifact_dependency; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.final_artifact_dependency (
    artif_dep_id character varying(40) NOT NULL,
    build_state_id bigint,
    source_build_type_id character varying(80),
    revision_rule character varying(80),
    branch character varying(255),
    src_paths character varying(40960)
);


ALTER TABLE public.final_artifact_dependency OWNER TO teamcity;

--
-- Name: hidden_health_item; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.hidden_health_item (
    item_id bigint NOT NULL,
    user_id bigint
);


ALTER TABLE public.hidden_health_item OWNER TO teamcity;

--
-- Name: history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.history (
    build_id bigint NOT NULL,
    agent_name character varying(256),
    build_type_id character varying(80),
    branch_name character varying(1024),
    build_start_time_server bigint,
    build_start_time_agent bigint,
    build_finish_time_server bigint,
    remove_from_queue_time bigint,
    queued_time bigint,
    status integer,
    status_text character varying(256),
    user_status_text character varying(256),
    pin integer,
    is_personal integer,
    is_canceled integer,
    build_number character varying(512),
    requestor character varying(1024),
    build_state_id bigint,
    agent_type_id integer
);


ALTER TABLE public.history OWNER TO teamcity;

--
-- Name: ids_group; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.ids_group (
    id integer NOT NULL,
    group_hash character varying(80) NOT NULL
);


ALTER TABLE public.ids_group OWNER TO teamcity;

--
-- Name: ids_group_entity_id; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.ids_group_entity_id (
    group_id integer NOT NULL,
    entity_id character varying(160) NOT NULL
);


ALTER TABLE public.ids_group_entity_id OWNER TO teamcity;

--
-- Name: ignored_tests; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.ignored_tests (
    build_id bigint,
    test_id integer,
    ignore_reason character varying(2000)
);


ALTER TABLE public.ignored_tests OWNER TO teamcity;

--
-- Name: inspection_data; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_data (
    hash bigint NOT NULL,
    result character varying(4000),
    severity integer,
    type_pattern integer,
    fqname character varying(4000),
    file_name character varying(255),
    parent_fqnames character varying(4000),
    parent_type_patterns character varying(20),
    module_name character varying(40),
    inspection_id bigint,
    is_local integer,
    used integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.inspection_data OWNER TO teamcity;

--
-- Name: inspection_diff; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_diff (
    build_id bigint NOT NULL,
    hash bigint NOT NULL
);


ALTER TABLE public.inspection_diff OWNER TO teamcity;

--
-- Name: inspection_fixes; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_fixes (
    hash bigint NOT NULL,
    hint character varying(255)
);


ALTER TABLE public.inspection_fixes OWNER TO teamcity;

--
-- Name: inspection_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_info (
    id bigint NOT NULL,
    inspection_id character varying(255),
    inspection_name character varying(255),
    inspection_desc character varying(4000),
    group_name character varying(255)
);


ALTER TABLE public.inspection_info OWNER TO teamcity;

--
-- Name: inspection_results; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_results (
    build_id bigint NOT NULL,
    hash bigint NOT NULL,
    line integer NOT NULL
);


ALTER TABLE public.inspection_results OWNER TO teamcity;

--
-- Name: inspection_stats; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.inspection_stats (
    build_id bigint NOT NULL,
    total integer,
    new_total integer,
    old_total integer,
    errors integer,
    new_errors integer,
    old_errors integer
);


ALTER TABLE public.inspection_stats OWNER TO teamcity;

--
-- Name: light_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.light_history (
    build_id bigint NOT NULL,
    agent_name character varying(80),
    build_type_id character varying(80),
    build_start_time_server bigint,
    build_start_time_agent bigint,
    build_finish_time_server bigint,
    status integer,
    status_text character varying(256),
    user_status_text character varying(256),
    pin integer,
    is_personal integer,
    is_canceled integer,
    build_number character varying(256),
    requestor character varying(1024),
    queued_time bigint,
    remove_from_queue_time bigint,
    build_state_id bigint,
    agent_type_id integer,
    branch_name character varying(255)
);


ALTER TABLE public.light_history OWNER TO teamcity;

--
-- Name: long_file_name; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.long_file_name (
    hash character varying(40) NOT NULL,
    file_name character varying(16000) NOT NULL
);


ALTER TABLE public.long_file_name OWNER TO teamcity;

--
-- Name: meta_file_line; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.meta_file_line (
    file_name character varying(15) NOT NULL,
    line_nr integer NOT NULL,
    line_text character varying(160)
);


ALTER TABLE public.meta_file_line OWNER TO teamcity;

--
-- Name: mute_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_info (
    mute_id integer NOT NULL,
    muting_user_id bigint NOT NULL,
    muting_time timestamp without time zone NOT NULL,
    muting_comment character varying(2000),
    scope character(1) NOT NULL,
    project_int_id character varying(80) NOT NULL,
    build_id bigint,
    unmute_when_fixed smallint,
    unmute_by_time timestamp without time zone
);


ALTER TABLE public.mute_info OWNER TO teamcity;

--
-- Name: mute_info_bt; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_info_bt (
    mute_id integer NOT NULL,
    build_type_id character varying(80) NOT NULL
);


ALTER TABLE public.mute_info_bt OWNER TO teamcity;

--
-- Name: mute_info_problem; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_info_problem (
    mute_id integer NOT NULL,
    problem_id integer NOT NULL
);


ALTER TABLE public.mute_info_problem OWNER TO teamcity;

--
-- Name: mute_info_test; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_info_test (
    mute_id integer NOT NULL,
    test_name_id bigint NOT NULL
);


ALTER TABLE public.mute_info_test OWNER TO teamcity;

--
-- Name: mute_problem_in_bt; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_problem_in_bt (
    mute_id integer NOT NULL,
    build_type_id character varying(80) NOT NULL,
    problem_id integer NOT NULL
);


ALTER TABLE public.mute_problem_in_bt OWNER TO teamcity;

--
-- Name: mute_problem_in_proj; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_problem_in_proj (
    mute_id integer NOT NULL,
    project_int_id character varying(80) NOT NULL,
    problem_id integer NOT NULL
);


ALTER TABLE public.mute_problem_in_proj OWNER TO teamcity;

--
-- Name: mute_test_in_bt; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_test_in_bt (
    mute_id integer NOT NULL,
    build_type_id character varying(80) NOT NULL,
    test_name_id bigint NOT NULL
);


ALTER TABLE public.mute_test_in_bt OWNER TO teamcity;

--
-- Name: mute_test_in_proj; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.mute_test_in_proj (
    mute_id integer NOT NULL,
    project_int_id character varying(80) NOT NULL,
    test_name_id bigint NOT NULL
);


ALTER TABLE public.mute_test_in_proj OWNER TO teamcity;

--
-- Name: node_events; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.node_events (
    id bigint NOT NULL,
    name character varying(64),
    long_arg1 bigint,
    long_arg2 bigint,
    str_arg character varying(255),
    node_id character varying(80) NOT NULL,
    created timestamp without time zone
);


ALTER TABLE public.node_events OWNER TO teamcity;

--
-- Name: node_locks; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.node_locks (
    lock_type character varying(64) NOT NULL,
    lock_arg character varying(80),
    id bigint NOT NULL,
    node_id character varying(80) NOT NULL,
    state integer NOT NULL,
    created bigint NOT NULL
);


ALTER TABLE public.node_locks OWNER TO teamcity;

--
-- Name: node_tasks; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.node_tasks (
    id integer NOT NULL,
    task_type character varying(64) NOT NULL,
    task_identity character varying(255) NOT NULL,
    long_arg1 bigint,
    long_arg2 bigint,
    str_arg character varying(1024),
    long_str_arg_uuid character varying(40),
    node_id character varying(80) NOT NULL,
    executor_node_id character varying(80),
    task_state integer NOT NULL,
    result character varying(1024),
    long_result_uuid character varying(40),
    created timestamp without time zone,
    finished timestamp without time zone,
    last_activity timestamp without time zone
);


ALTER TABLE public.node_tasks OWNER TO teamcity;

--
-- Name: node_tasks_long_value; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.node_tasks_long_value (
    uuid character varying(40) NOT NULL,
    long_value text NOT NULL
);


ALTER TABLE public.node_tasks_long_value OWNER TO teamcity;

--
-- Name: permanent_token_permissions; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.permanent_token_permissions (
    id bigint NOT NULL,
    project_id character varying(80) NOT NULL,
    permission integer NOT NULL
);


ALTER TABLE public.permanent_token_permissions OWNER TO teamcity;

--
-- Name: permanent_tokens; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.permanent_tokens (
    id bigint NOT NULL,
    identifier character varying(36) NOT NULL,
    name character varying(128) NOT NULL,
    user_id bigint NOT NULL,
    hashed_value character varying(255) NOT NULL,
    expiration_time bigint,
    creation_time bigint,
    last_access_time bigint,
    last_access_info character varying(255),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.permanent_tokens OWNER TO teamcity;

--
-- Name: personal_build_relative_path; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.personal_build_relative_path (
    build_id bigint,
    original_path_hash bigint,
    relative_path character varying(16000)
);


ALTER TABLE public.personal_build_relative_path OWNER TO teamcity;

--
-- Name: personal_vcs_change; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.personal_vcs_change (
    modification_id bigint NOT NULL,
    file_num integer NOT NULL,
    vcs_file_name character varying(2000) NOT NULL,
    vcs_file_name_hash character varying(40),
    relative_file_name_pos integer,
    relative_file_name character varying(2000),
    relative_file_name_hash character varying(40),
    change_type integer NOT NULL,
    change_name character varying(64),
    before_revision character varying(200),
    after_revision character varying(200)
);


ALTER TABLE public.personal_vcs_change OWNER TO teamcity;

--
-- Name: personal_vcs_changes; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.personal_vcs_changes (
    modification_id bigint,
    change_name character varying(64),
    change_type integer,
    before_revision character varying(2048),
    after_revision character varying(2048),
    vcs_file_name character varying(16000),
    relative_file_name character varying(16000)
);


ALTER TABLE public.personal_vcs_changes OWNER TO teamcity;

--
-- Name: personal_vcs_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.personal_vcs_history (
    modification_id bigint NOT NULL,
    modification_hash character varying(40) NOT NULL,
    user_id bigint NOT NULL,
    description character varying(2000),
    change_date bigint NOT NULL,
    changes_count integer NOT NULL,
    commit_changes integer,
    status integer DEFAULT 0 NOT NULL,
    scheduled_for_deletion smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.personal_vcs_history OWNER TO teamcity;

--
-- Name: problem; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.problem (
    problem_id integer NOT NULL,
    problem_type character varying(80) NOT NULL,
    problem_identity character varying(60) NOT NULL
);


ALTER TABLE public.problem OWNER TO teamcity;

--
-- Name: project; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.project (
    int_id character varying(80) NOT NULL,
    config_id character varying(80) NOT NULL,
    origin_project_id character varying(80),
    delete_time bigint
);


ALTER TABLE public.project OWNER TO teamcity;

--
-- Name: project_files; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.project_files (
    file_id bigint NOT NULL,
    file_name character varying(255) NOT NULL
);


ALTER TABLE public.project_files OWNER TO teamcity;

--
-- Name: project_mapping; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.project_mapping (
    int_id character varying(80) NOT NULL,
    ext_id character varying(240) NOT NULL,
    main smallint NOT NULL
);


ALTER TABLE public.project_mapping OWNER TO teamcity;

--
-- Name: remember_me; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.remember_me (
    user_key character varying(65) NOT NULL,
    secure bigint NOT NULL
);


ALTER TABLE public.remember_me OWNER TO teamcity;

--
-- Name: removed_builds_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.removed_builds_history (
    build_id bigint NOT NULL,
    agent_name character varying(256),
    build_type_id character varying(80),
    build_start_time_server bigint,
    build_start_time_agent bigint,
    build_finish_time_server bigint,
    status integer,
    status_text character varying(256),
    user_status_text character varying(256),
    pin integer,
    is_personal integer,
    is_canceled integer,
    build_number character varying(512),
    requestor character varying(1024),
    queued_time bigint,
    remove_from_queue_time bigint,
    build_state_id bigint,
    agent_type_id integer,
    branch_name character varying(1024)
);


ALTER TABLE public.removed_builds_history OWNER TO teamcity;

--
-- Name: repository_state; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.repository_state (
    vcs_root_id integer NOT NULL,
    node_id character varying(80) NOT NULL,
    update_time bigint NOT NULL
);


ALTER TABLE public.repository_state OWNER TO teamcity;

--
-- Name: repository_state_branches; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.repository_state_branches (
    vcs_root_id integer NOT NULL,
    branch_id bigint NOT NULL,
    revision character varying(256) NOT NULL,
    creation_time bigint NOT NULL
);


ALTER TABLE public.repository_state_branches OWNER TO teamcity;

--
-- Name: responsibilities; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.responsibilities (
    problem_id character varying(80) NOT NULL,
    state integer NOT NULL,
    responsible_user_id bigint NOT NULL,
    reporter_user_id bigint,
    timestmp bigint,
    remove_method integer DEFAULT 0 NOT NULL,
    comments character varying(4096)
);


ALTER TABLE public.responsibilities OWNER TO teamcity;

--
-- Name: running; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.running (
    build_id bigint NOT NULL,
    agent_id integer,
    build_type_id character varying(80),
    build_start_time_agent bigint,
    build_start_time_server bigint,
    build_finish_time_server bigint,
    last_build_activity_time bigint,
    is_personal integer,
    build_number character varying(512),
    build_counter bigint,
    requestor character varying(1024),
    access_code character varying(60),
    queued_ag_restr_type_id integer,
    queued_ag_restr_id integer,
    build_state_id bigint,
    agent_type_id integer,
    user_status_text character varying(256),
    progress_text character varying(1024),
    current_path_text character varying(2048)
);


ALTER TABLE public.running OWNER TO teamcity;

--
-- Name: server; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.server (
    server_id bigint
);


ALTER TABLE public.server OWNER TO teamcity;

--
-- Name: server_health_items; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.server_health_items (
    id bigint NOT NULL,
    report_id character varying(80) NOT NULL,
    category_id character varying(80) NOT NULL,
    item_id character varying(255) NOT NULL
);


ALTER TABLE public.server_health_items OWNER TO teamcity;

--
-- Name: server_property; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.server_property (
    prop_name character varying(80) NOT NULL,
    prop_value character varying(256) NOT NULL
);


ALTER TABLE public.server_property OWNER TO teamcity;

--
-- Name: server_statistics; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.server_statistics (
    metric_key bigint NOT NULL,
    metric_value bigint NOT NULL,
    metric_timestamp bigint NOT NULL
);


ALTER TABLE public.server_statistics OWNER TO teamcity;

--
-- Name: single_row; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.single_row (
    dummy_field character(1)
);


ALTER TABLE public.single_row OWNER TO teamcity;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.stats (
    build_id bigint NOT NULL,
    test_count integer
);


ALTER TABLE public.stats OWNER TO teamcity;

--
-- Name: stats_publisher_state; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.stats_publisher_state (
    metric_id bigint NOT NULL,
    value bigint NOT NULL
);


ALTER TABLE public.stats_publisher_state OWNER TO teamcity;

--
-- Name: test_failure_rate; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_failure_rate (
    build_type_id character varying(80) NOT NULL,
    test_name_id bigint NOT NULL,
    success_count integer,
    failure_count integer,
    last_failure_time bigint
);


ALTER TABLE public.test_failure_rate OWNER TO teamcity;

--
-- Name: test_info; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_info (
    build_id bigint NOT NULL,
    test_id integer NOT NULL,
    test_name_id bigint,
    status integer,
    duration integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.test_info OWNER TO teamcity;

--
-- Name: test_info_archive; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_info_archive (
    build_id bigint NOT NULL,
    test_id integer NOT NULL,
    test_name_id bigint NOT NULL,
    status integer,
    duration integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.test_info_archive OWNER TO teamcity;

--
-- Name: test_metadata; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_metadata (
    build_id bigint NOT NULL,
    test_id integer NOT NULL,
    test_name_id bigint NOT NULL,
    key_id bigint NOT NULL,
    type_id integer,
    str_value character varying(1024),
    num_value numeric(19,6)
);


ALTER TABLE public.test_metadata OWNER TO teamcity;

--
-- Name: test_metadata_dict; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_metadata_dict (
    key_id bigint NOT NULL,
    name_digest character varying(32) NOT NULL,
    name character varying(512) NOT NULL
);


ALTER TABLE public.test_metadata_dict OWNER TO teamcity;

--
-- Name: test_metadata_types; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_metadata_types (
    type_id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.test_metadata_types OWNER TO teamcity;

--
-- Name: test_muted; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_muted (
    build_id bigint NOT NULL,
    test_name_id bigint NOT NULL,
    mute_id integer NOT NULL
);


ALTER TABLE public.test_muted OWNER TO teamcity;

--
-- Name: test_names; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.test_names (
    id bigint NOT NULL,
    test_name character varying(1024) NOT NULL,
    order_num bigint
);


ALTER TABLE public.test_names OWNER TO teamcity;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_attribute (
    user_id bigint NOT NULL,
    attr_key character varying(80) NOT NULL,
    attr_value character varying(2000),
    locase_value_hash bigint
);


ALTER TABLE public.user_attribute OWNER TO teamcity;

--
-- Name: user_blocks; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_blocks (
    user_id bigint NOT NULL,
    block_type character varying(80) NOT NULL,
    state character varying(2048)
);


ALTER TABLE public.user_blocks OWNER TO teamcity;

--
-- Name: user_build_parameters; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_build_parameters (
    build_state_id bigint,
    param_name character varying(2000),
    param_value character varying(16000)
);


ALTER TABLE public.user_build_parameters OWNER TO teamcity;

--
-- Name: user_build_types_order; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_build_types_order (
    user_id bigint NOT NULL,
    project_int_id character varying(80) NOT NULL,
    bt_int_id character varying(80) NOT NULL,
    ordernum integer NOT NULL,
    visible integer NOT NULL
);


ALTER TABLE public.user_build_types_order OWNER TO teamcity;

--
-- Name: user_notification_data; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_notification_data (
    user_id bigint NOT NULL,
    rule_id bigint NOT NULL,
    additional_data character varying(2000)
);


ALTER TABLE public.user_notification_data OWNER TO teamcity;

--
-- Name: user_notification_events; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_notification_events (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    notificator_type character varying(20) NOT NULL,
    events_mask integer NOT NULL
);


ALTER TABLE public.user_notification_events OWNER TO teamcity;

--
-- Name: user_projects_order; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_projects_order (
    user_id bigint NOT NULL,
    project_int_id character varying(80) NOT NULL,
    ordernum integer
);


ALTER TABLE public.user_projects_order OWNER TO teamcity;

--
-- Name: user_projects_visibility; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_projects_visibility (
    user_id bigint NOT NULL,
    project_int_id character varying(80) NOT NULL,
    visible integer NOT NULL
);


ALTER TABLE public.user_projects_visibility OWNER TO teamcity;

--
-- Name: user_property; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_property (
    user_id bigint NOT NULL,
    prop_key character varying(80) NOT NULL,
    prop_value character varying(2000),
    locase_value_hash bigint
);


ALTER TABLE public.user_property OWNER TO teamcity;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id character varying(80) NOT NULL,
    project_int_id character varying(80)
);


ALTER TABLE public.user_roles OWNER TO teamcity;

--
-- Name: user_watch_type; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.user_watch_type (
    rule_id bigint NOT NULL,
    user_id bigint NOT NULL,
    notificator_type character varying(20) NOT NULL,
    watch_type integer NOT NULL,
    watch_value character varying(80) NOT NULL,
    order_num bigint
);


ALTER TABLE public.user_watch_type OWNER TO teamcity;

--
-- Name: usergroup_notification_data; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_notification_data (
    group_id character varying(80) NOT NULL,
    rule_id bigint NOT NULL,
    additional_data character varying(2000)
);


ALTER TABLE public.usergroup_notification_data OWNER TO teamcity;

--
-- Name: usergroup_notification_events; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_notification_events (
    id bigint NOT NULL,
    group_id character varying(80) NOT NULL,
    notificator_type character varying(20) NOT NULL,
    events_mask integer NOT NULL
);


ALTER TABLE public.usergroup_notification_events OWNER TO teamcity;

--
-- Name: usergroup_property; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_property (
    group_id character varying(80) NOT NULL,
    prop_key character varying(80) NOT NULL,
    prop_value character varying(2000)
);


ALTER TABLE public.usergroup_property OWNER TO teamcity;

--
-- Name: usergroup_roles; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_roles (
    group_id character varying(80) NOT NULL,
    role_id character varying(80) NOT NULL,
    project_int_id character varying(80)
);


ALTER TABLE public.usergroup_roles OWNER TO teamcity;

--
-- Name: usergroup_subgroups; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_subgroups (
    hostgroup_id character varying(80) NOT NULL,
    subgroup_id character varying(80) NOT NULL
);


ALTER TABLE public.usergroup_subgroups OWNER TO teamcity;

--
-- Name: usergroup_users; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_users (
    group_id character varying(80) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.usergroup_users OWNER TO teamcity;

--
-- Name: usergroup_watch_type; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroup_watch_type (
    rule_id bigint NOT NULL,
    group_id character varying(80) NOT NULL,
    notificator_type character varying(20) NOT NULL,
    watch_type integer NOT NULL,
    watch_value character varying(80) NOT NULL,
    order_num bigint
);


ALTER TABLE public.usergroup_watch_type OWNER TO teamcity;

--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.usergroups (
    group_id character varying(80) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(2000)
);


ALTER TABLE public.usergroups OWNER TO teamcity;

--
-- Name: users; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(191) NOT NULL,
    password character varying(128),
    name character varying(256),
    email character varying(256),
    last_login_timestamp bigint,
    algorithm character varying(20)
);


ALTER TABLE public.users OWNER TO teamcity;

--
-- Name: vcs_change; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_change (
    modification_id bigint NOT NULL,
    file_num integer NOT NULL,
    vcs_file_name character varying(2000) NOT NULL,
    vcs_file_name_hash character varying(40),
    relative_file_name_pos integer,
    relative_file_name character varying(2000),
    relative_file_name_hash character varying(40),
    change_type integer NOT NULL,
    change_name character varying(64),
    before_revision character varying(200),
    after_revision character varying(200)
);


ALTER TABLE public.vcs_change OWNER TO teamcity;

--
-- Name: vcs_change_attrs; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_change_attrs (
    modification_id bigint NOT NULL,
    attr_name character varying(200) NOT NULL,
    attr_value character varying(1000)
);


ALTER TABLE public.vcs_change_attrs OWNER TO teamcity;

--
-- Name: vcs_changes; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_changes (
    modification_id bigint,
    change_name character varying(64),
    change_type integer,
    before_revision character varying(2048),
    after_revision character varying(2048),
    vcs_file_name character varying(16000),
    relative_file_name character varying(16000)
);


ALTER TABLE public.vcs_changes OWNER TO teamcity;

--
-- Name: vcs_changes_graph; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_changes_graph (
    child_modification_id bigint NOT NULL,
    child_revision character varying(200) NOT NULL,
    parent_num integer NOT NULL,
    parent_modification_id bigint,
    parent_revision character varying(200) NOT NULL
);


ALTER TABLE public.vcs_changes_graph OWNER TO teamcity;

--
-- Name: vcs_history; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_history (
    modification_id bigint NOT NULL,
    user_name character varying(255),
    description character varying(2000),
    change_date bigint,
    register_date bigint,
    vcs_root_id integer,
    changes_count integer,
    version character varying(200) NOT NULL,
    display_version character varying(200)
);


ALTER TABLE public.vcs_history OWNER TO teamcity;

--
-- Name: vcs_root; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_root (
    int_id integer NOT NULL,
    config_id character varying(80) NOT NULL,
    origin_project_id character varying(80),
    delete_time bigint
);


ALTER TABLE public.vcs_root OWNER TO teamcity;

--
-- Name: vcs_root_first_revision; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_root_first_revision (
    build_type_id character varying(80) NOT NULL,
    parent_root_id integer NOT NULL,
    settings_hash bigint NOT NULL,
    vcs_revision character varying(200) NOT NULL
);


ALTER TABLE public.vcs_root_first_revision OWNER TO teamcity;

--
-- Name: vcs_root_instance; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_root_instance (
    id integer NOT NULL,
    parent_id integer NOT NULL,
    settings_hash bigint NOT NULL,
    body character varying(16384)
);


ALTER TABLE public.vcs_root_instance OWNER TO teamcity;

--
-- Name: vcs_root_mapping; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_root_mapping (
    int_id integer NOT NULL,
    ext_id character varying(240) NOT NULL,
    main smallint NOT NULL
);


ALTER TABLE public.vcs_root_mapping OWNER TO teamcity;

--
-- Name: vcs_username; Type: TABLE; Schema: public; Owner: teamcity
--

CREATE TABLE public.vcs_username (
    user_id bigint NOT NULL,
    vcs_name character varying(60) NOT NULL,
    parent_vcs_root_id integer NOT NULL,
    order_num integer NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.vcs_username OWNER TO teamcity;

--
-- Data for Name: action_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.action_history (object_id, comment_id, action, additional_data) FROM stdin;
1	1	15	\N
_Root	2	87	\N
1	3	11	\N
\.


--
-- Data for Name: agent; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent (id, name, host_addr, port, agent_type_id, status, authorized, registered, registration_timestamp, last_binding_timestamp, unregistered_reason, authorization_token, status_to_restore, status_restoring_timestamp, version, plugins_version) FROM stdin;
1	1ae82a43-081d-47d9-9339-4baf33a32ce4	10.1.1.222	9090	1	1	1	1	1753006304840	1753006943608	\N	e7a2fd24e9816cc25492cae9846e491a	\N	\N	186370	186370-md5-d01eb818c96594575f861993ed6fb282
\.


--
-- Data for Name: agent_pool; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_pool (agent_pool_id, agent_pool_name, min_agents, max_agents, owner_project_id) FROM stdin;
0	Default	\N	\N	\N
\.


--
-- Data for Name: agent_pool_project; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_pool_project (agent_pool_id, project_int_id) FROM stdin;
0	_Root
\.


--
-- Data for Name: agent_type; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type (agent_type_id, agent_pool_id, cloud_code, profile_id, image_id, policy) FROM stdin;
1	0	kube	kube-1	teamcity-agent	1
\.


--
-- Data for Name: agent_type_bt_access; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type_bt_access (agent_type_id, build_type_id) FROM stdin;
\.


--
-- Data for Name: agent_type_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type_info (agent_type_id, os_name, cpu_rank, created_timestamp, modified_timestamp) FROM stdin;
1	Linux, version 6.6.87.2-microsoft-standard-WSL2	335	2025-07-20 10:11:44.859	2025-07-20 10:11:44.859
\.


--
-- Data for Name: agent_type_param; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type_param (agent_type_id, param_kind, param_name, param_value) FROM stdin;
1	B	env.PWD	/opt/buildagent/bin
1	B	env.KUBERNETES_PORT_443_TCP_ADDR	10.96.0.1
1	B	env.LANG	C.UTF-8
1	B	env.NUGET_XMLDOC_MODE	skip
1	B	env.DEBIAN_FRONTEND	noninteractive
1	B	env.TEAMCITY_AGENT_PORT_9090_TCP	tcp://10.102.162.201:9090
1	B	env.HOME	/home/buildagent
1	B	env.TEAMCITY_AGENT_PORT_9090_TCP_PORT	9090
1	B	system.agent.work.dir	/opt/buildagent/work
1	B	env.CONFIG_FILE	/data/teamcity_agent/conf/buildAgent.properties
1	B	env.KUBERNETES_PORT_443_TCP	tcp://10.96.0.1:443
1	B	env.KUBERNETES_SERVICE_PORT_HTTPS	443
1	B	env.ASPNETCORE_URLS	http://+:80
1	B	env.GIT_SSH_VARIANT	ssh
1	B	env.SERVER_URL	http://haproxy.teamcity-server.svc.cluster.local
1	B	env.KUBERNETES_PORT_443_TCP_PORT	443
1	B	env.JDK_21_0_x64	/opt/java/openjdk
1	B	env.TC_K8S_SERVER_URL	http://haproxy.teamcity-server.svc.cluster.local
1	B	env.TEAMCITY_AGENT_PORT	tcp://10.102.162.201:9090
1	B	env.DOTNET_SKIP_FIRST_TIME_EXPERIENCE	true
1	B	env.TC_K8S_PROVIDED_teamcity_agent_startingInstanceId	5FAktL9Pf7XAKnjsUWeoE5K9ugh8peMy
1	B	system.teamcity.agent.cpuBenchmark	335
1	B	env.TEAMCITY_AGENT_SERVICE_HOST	10.102.162.201
1	B	env.DOTNET_RUNNING_IN_CONTAINER	true
1	B	env.JAVA_HOME	/opt/java/openjdk
1	B	env.TC_K8S_STARTING_INSTANCE_ID	5FAktL9Pf7XAKnjsUWeoE5K9ugh8peMy
1	B	env.JRE_HOME	/opt/java/openjdk
1	B	env.TEAMCITY_GIT_PATH	/usr/bin/git
1	B	env.JDK_21_0	/opt/java/openjdk
1	B	env.DOTNET_USE_POLLING_FILE_WATCHER	true
1	B	env.TEAMCITY_AGENT_PORT_9090_TCP_ADDR	10.102.162.201
1	B	env.TC_K8S_CLOUD_PROFILE_ID	kube-1
1	B	env.TC_K8S_INSTANCE_NAME	1ae82a43-081d-47d9-9339-4baf33a32ce4
1	B	env.TZ	Europe/London
1	B	env.LANGUAGE	en_US:en
1	B	env.TEAMCITY_GIT_VERSION	2.49.0.0
1	B	env.KUBERNETES_PORT_443_TCP_PROTO	tcp
1	B	env.PATH	/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
1	B	env.LC_ALL	en_US.UTF-8
1	B	env.TEAMCITY_CAPTURE_ENV	"/opt/java/openjdk/bin/java" -jar "/opt/buildagent/plugins/environment-fetcher/lib/environment-fetcher-bin-2025.03-186370-jar-with-dependencies.jar"
1	B	env.KUBERNETES_SERVICE_PORT	443
1	B	env.TC_K8S_SERVER_UUID	f8356630-8991-49c6-961f-fad24504090c
1	B	env.TC_K8S_PROVIDED_system_cloud_profile_id	kube-1
1	B	env.HOSTNAME	1ae82a43-081d-47d9-9339-4baf33a32ce4
1	B	env._	/usr/bin/nohup
1	B	env.SHLVL	1
1	B	env.KUBERNETES_PORT	tcp://10.96.0.1:443
1	B	env.DOTNET_SDK_VERSION	\N
1	B	env.KUBERNETES_SERVICE_HOST	10.96.0.1
1	B	system.teamcity.build.tempDir	/opt/buildagent/temp/buildTmp
1	B	env.DOTNET_CLI_TELEMETRY_OPTOUT	true
1	B	env.TC_K8S_IMAGE_NAME	teamcity-agent
1	B	env.TEAMCITY_AGENT_PORT_9090_TCP_PROTO	tcp
1	B	system.agent.home.dir	/opt/buildagent
1	B	env.TEAMCITY_AGENT_SERVICE_PORT	9090
1	B	env.JDK_HOME	/opt/java/openjdk
1	B	env.OLDPWD	/
1	B	system.agent.name	1ae82a43-081d-47d9-9339-4baf33a32ce4
1	C	teamcity.agent.os.arch.bits	64
1	C	teamcity.agent.work.dir	/opt/buildagent/work
1	C	teamcity.vault.supported	true
1	C	DotNetCoreSDK8.0_Path	/usr/share/dotnet/sdk/8.0.406
1	C	system.cloud.profile_id	kube-1
1	C	teamcity.tool.gant	/opt/buildagent/tools/gant
1	C	teamcity.hg.version	6.1.1
1	C	teamcity.agent.jvm.file.separator	/
1	C	teamcity.agent.jvm.user.name	buildagent
1	C	docker.version	27.5.1
1	C	teamcity.agent.jvm.vendor	Amazon.com Inc.
1	C	DotNetCoreRuntime8.0_Path	/usr/share/dotnet/shared/Microsoft.NETCore.App/8.0.13
1	C	teamcity.git.ssh.version	OpenSSH_8.9p1 Ubuntu-3ubuntu0.1
1	C	DotNetCoreRuntime8.0.13_Path	/usr/share/dotnet/shared/Microsoft.NETCore.App/8.0.13
1	C	teamcity.dotCover.home	%teamcity.tool.JetBrains.dotCover.CommandLineTools.bundled%
1	C	teamcity.agent.jvm.os.name	Linux
1	C	system.cloud.profile.id	kube-1
1	C	teamcity.agent.hostname	1ae82a43-081d-47d9-9339-4baf33a32ce4
1	C	teamcity.agent.ownPort	9090
1	C	teamcity.agent.jvm.os.arch	amd64
1	C	teamcity.agent.protocol	polling
1	C	teamcity.gitLfs.version	3.6.1
1	C	teamcity.agent.launcher.version	2025.03-186370
1	C	teamcity.agent.tools.dir	/opt/buildagent/tools
1	C	DotNetCredentialProvider1.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp1.0/CredentialProvider.TeamCity.dll
1	C	DotNetCoreSDK8.0.406_Path	/usr/share/dotnet/sdk/8.0.406
1	C	python3.executable	/usr/bin/python3
1	C	teamcity.agent.jvm.java.home	/opt/java/openjdk
1	C	DotNetCredentialProvider6.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net6.0/CredentialProvider.TeamCity.dll
1	C	teamcity.agent.hardware.memorySizeMb	2048
1	C	teamcity.agent.jvm.path.separator	:
1	C	teamcity.tool.ant-net-tasks	/opt/buildagent/tools/ant-net-tasks
1	C	teamcity.agent.hardware.cpuCount	2
1	C	system_cloud_profile_id	kube-1
1	C	teamcity.agent.jvm.user.home	/home/buildagent
1	C	teamcity.hg.agent.path	hg
1	C	pythonAny.executable	/usr/bin/python3
1	C	teamcity_agent_startingInstanceId	5FAktL9Pf7XAKnjsUWeoE5K9ugh8peMy
1	C	DotNetCredentialProvider2.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp2.0/CredentialProvider.TeamCity.dll
1	C	DotNetCLI_Path	/usr/share/dotnet/dotnet
1	C	teamcity.agent.work.dir.freeSpaceMb	949394
1	C	teamcity.agent.jvm.file.encoding	UTF-8
1	C	DotNetCLI	8.0.406
1	C	DotNetCredentialProvider5.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net5.0/CredentialProvider.TeamCity.dll
1	C	teamcity.artifactDependenciesResolution.allowedList	/opt/buildagent/system/jetbrains.maven.runner,/opt/buildagent/system/jetbrains.gradle.runner,/opt/buildagent/system/jetbrains.dotnet.runner
1	C	teamcity.serverUrl	http://haproxy.teamcity-server.svc.cluster.local
1	C	teamcity.agent.jvm.user.timezone	Europe/London
1	C	teamcity.tool.dotCover	%teamcity.tool.JetBrains.dotCover.CommandLineTools.bundled%
1	C	teamcity.agent.jvm.specification	21
1	C	teamcity.agent.home.dir	/opt/buildagent
1	C	teamcity.agent.jvm.os.version	6.6.87.2-microsoft-standard-WSL2
1	C	DotNetCredentialProvider4.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/net46/CredentialProvider.TeamCity.exe
1	C	teamcity.agent.jvm.version	21.0.6
1	C	teamcity.tool.jps	/opt/buildagent/tools/jps
1	C	teamcity.agent.jvm.user.language	en
1	C	teamcity.agent.jvm.user.country	US
1	C	teamcity.agent.name	1ae82a43-081d-47d9-9339-4baf33a32ce4
1	C	DotNetCredentialProvider3.0.0_Path	/opt/buildagent/plugins/nuget-agent/bin/credential-plugin/netcoreapp3.0/CredentialProvider.TeamCity.dll
\.


--
-- Data for Name: agent_type_runner; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type_runner (agent_type_id, runner) FROM stdin;
1	dotnet
1	Ant
1	JPS
1	kotlinScript
1	python-runner
1	ssh-deploy-runner
1	nunit-console
1	Maven2
1	jetbrains_powershell
1	ssh-exec-runner
1	dotnet-tools-inspectcode
1	smb-deploy-runner
1	SBT
1	Duplicator
1	cargo-deploy-runner
1	Inspection
1	dotcover
1	Qodana
1	csharpScript
1	dotnet-tools-dupfinder
1	gradle-runner
1	simpleRunner
1	rake-runner
1	DockerCommand
1	nodejs-runner
1	ftp-deploy-runner
\.


--
-- Data for Name: agent_type_vcs; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.agent_type_vcs (agent_type_id, vcs) FROM stdin;
1	tfs
1	jetbrains.git
1	mercurial
1	svn
1	perforce
\.


--
-- Data for Name: audit_additional_object; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.audit_additional_object (comment_id, object_index, object_id, object_name) FROM stdin;
2	0	project:_Root|1|2	version before: 1, version after: 2
\.


--
-- Data for Name: backup_builds; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.backup_builds (build_id) FROM stdin;
\.


--
-- Data for Name: backup_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.backup_info (mproc_id, file_name, file_size, started, finished, status) FROM stdin;
\.


--
-- Data for Name: branch_name_dict; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.branch_name_dict (id, branch_name, branch_name_hash, insertion_time) FROM stdin;
\.


--
-- Data for Name: build_artifact_dependency; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_artifact_dependency (artif_dep_id, build_state_id, source_build_type_id, revision_rule, branch, src_paths) FROM stdin;
\.


--
-- Data for Name: build_attrs; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_attrs (build_state_id, attr_name, attr_value, attr_num_value) FROM stdin;
\.


--
-- Data for Name: build_checkout_rules; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_checkout_rules (build_state_id, vcs_root_id, checkout_rules) FROM stdin;
\.


--
-- Data for Name: build_data_storage; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_data_storage (build_id, metric_id, metric_value) FROM stdin;
\.


--
-- Data for Name: build_dependency; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_dependency (build_state_id, depends_on, dependency_options) FROM stdin;
\.


--
-- Data for Name: build_labels; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_labels (build_id, vcs_root_id, label, status, error_message) FROM stdin;
\.


--
-- Data for Name: build_overriden_roots; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_overriden_roots (build_state_id, original_vcs_root_id, substitution_vcs_root_id) FROM stdin;
\.


--
-- Data for Name: build_problem; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_problem (build_state_id, problem_id, problem_description) FROM stdin;
\.


--
-- Data for Name: build_problem_attribute; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_problem_attribute (build_state_id, problem_id, attr_name, attr_value) FROM stdin;
\.


--
-- Data for Name: build_problem_muted; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_problem_muted (build_state_id, problem_id, mute_id) FROM stdin;
\.


--
-- Data for Name: build_project; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_project (build_id, project_level, project_int_id) FROM stdin;
\.


--
-- Data for Name: build_queue; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_queue (build_type_id, agent_restrictor_type_id, agent_restrictor_id, requestor, build_state_id) FROM stdin;
\.


--
-- Data for Name: build_queue_order; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_queue_order (version, line_num, promotion_ids) FROM stdin;
0	1	
\.


--
-- Data for Name: build_revisions; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_revisions (build_state_id, vcs_root_id, vcs_revision, vcs_revision_display_name, vcs_branch_name, modification_id, vcs_root_type, checkout_mode) FROM stdin;
\.


--
-- Data for Name: build_set_tmp; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_set_tmp (build_id) FROM stdin;
\.


--
-- Data for Name: build_state; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_state (id, build_id, build_type_id, modification_id, chain_modification_id, personal_modification_id, personal_user_id, is_personal, is_canceled, is_changes_detached, is_deleted, branch_name, queued_time, remove_from_queue_time) FROM stdin;
\.


--
-- Data for Name: build_state_private_tag; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_state_private_tag (build_state_id, owner, tag) FROM stdin;
\.


--
-- Data for Name: build_state_tag; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_state_tag (build_state_id, tag) FROM stdin;
\.


--
-- Data for Name: build_type; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type (int_id, config_id, origin_project_id, delete_time) FROM stdin;
\.


--
-- Data for Name: build_type_counters; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type_counters (build_type_id, counter) FROM stdin;
\.


--
-- Data for Name: build_type_edge_relation; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type_edge_relation (child_modification_id, build_type_id, parent_num, change_type) FROM stdin;
\.


--
-- Data for Name: build_type_group_vcs_change; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type_group_vcs_change (modification_id, group_id, change_type) FROM stdin;
\.


--
-- Data for Name: build_type_mapping; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type_mapping (int_id, ext_id, main) FROM stdin;
\.


--
-- Data for Name: build_type_vcs_change; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.build_type_vcs_change (modification_id, build_type_id, change_type) FROM stdin;
\.


--
-- Data for Name: canceled_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.canceled_info (build_id, user_id, description, interrupt_type) FROM stdin;
\.


--
-- Data for Name: clean_checkout_enforcement; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.clean_checkout_enforcement (build_type_id, agent_id, current_build_id, request_time) FROM stdin;
\.


--
-- Data for Name: cleanup_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cleanup_history (proc_id, start_time, finish_time, interrupt_reason) FROM stdin;
\.


--
-- Data for Name: cloud_image_state; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cloud_image_state (project_id, profile_id, image_id, name) FROM stdin;
\.


--
-- Data for Name: cloud_image_without_agent; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cloud_image_without_agent (profile_id, cloud_code, image_id, last_update) FROM stdin;
\.


--
-- Data for Name: cloud_instance_state; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cloud_instance_state (project_id, profile_id, image_id, instance_id, name, last_update, status, start_time, network_identity, is_expired, agent_id) FROM stdin;
\.


--
-- Data for Name: cloud_started_instance; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cloud_started_instance (profile_id, cloud_code, image_id, instance_id, last_update) FROM stdin;
\.


--
-- Data for Name: cloud_state_data; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.cloud_state_data (project_id, profile_id, image_id, instance_id, data) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.comments (id, author_id, when_changed, commentary) FROM stdin;
1	1	1753005816195	
2	1	1753006154249	Added cloud profile 'kube-1' in project '_Root'
3	-1	1753006187380	Virtual agent is authorized automatically.
\.


--
-- Data for Name: compiler_output; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.compiler_output (build_id, message_order, message) FROM stdin;
\.


--
-- Data for Name: config_persisting_tasks; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.config_persisting_tasks (id, task_type, description, stage, node_id, created, updated) FROM stdin;
1	global_settings	Save usage statistics settings	5	server-0	1753005808581	1753005809810
2	global_settings	Persist global settings	5	server-0	1753005879680	1753005880743
3	project_configs	Added cloud profile 'kube-1' in project '_Root'	5	server-0	1753006153743	1753006154266
4	project_configs	Storing 1 events into the multi-node events table	5	server-0	1753006165240	1753006165294
\.


--
-- Data for Name: custom_data; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.custom_data (data_key_hash, collision_idx, data_domain, data_key, data_id) FROM stdin;
0a75bc8cfeda5666c174245dec9aa98461750d97	0	java.lang.Class	jetbrains.buildServer.clouds.server.impl.instances.StartingCloudInstanceTokens	1
\.


--
-- Data for Name: custom_data_body; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.custom_data_body (id, part_num, total_parts, data_body, update_date) FROM stdin;
1	0	1	v1:kube-1:teamcity-agent:5FAktL9Pf7XAKnjsUWeoE5K9ugh8peMy=1753006155845\n	1753006186644
\.


--
-- Data for Name: data_storage_dict; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.data_storage_dict (metric_id, value_type_key) FROM stdin;
\.


--
-- Data for Name: db_heartbeat; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.db_heartbeat (node_id, starting_code, starting_time, lock_mode, ip_address, additional_info, last_time, update_interval, uuid, app_type, url, access_token, build_number, display_version, responsibilities, unix_last_time, unix_starting_time) FROM stdin;
\.


--
-- Data for Name: db_version; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.db_version (version_number, version_time, incompatible_change) FROM stdin;
1021	2025-07-20 10:01:40.939	1
\.


--
-- Data for Name: default_build_parameters; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.default_build_parameters (build_state_id, param_name, param_value) FROM stdin;
\.


--
-- Data for Name: domain_sequence; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.domain_sequence (domain_name, last_used_value) FROM stdin;
user_id	10
audit_comment_id	100
node_task_id	1310
agent_type_id	10
agent_id	10
\.


--
-- Data for Name: downloaded_artifacts; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.downloaded_artifacts (target_build_id, source_build_id, download_timestamp, artifact_path) FROM stdin;
\.


--
-- Data for Name: duplicate_diff; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.duplicate_diff (build_id, hash) FROM stdin;
\.


--
-- Data for Name: duplicate_fragments; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.duplicate_fragments (id, file_id, line, offset_info) FROM stdin;
\.


--
-- Data for Name: duplicate_results; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.duplicate_results (id, build_id, hash, cost) FROM stdin;
\.


--
-- Data for Name: duplicate_stats; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.duplicate_stats (build_id, total, new_total, old_total) FROM stdin;
\.


--
-- Data for Name: duplicate_vcs_modification; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.duplicate_vcs_modification (modification_id, orig_modification_id, register_date, vcs_root_id, changes_count) FROM stdin;
\.


--
-- Data for Name: failed_tests; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.failed_tests (test_name_id, build_id, test_id, ffi_build_id) FROM stdin;
\.


--
-- Data for Name: failed_tests_output; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.failed_tests_output (build_id, test_id, problem_description, std_output, error_output, stacktrace, expected, actual) FROM stdin;
\.


--
-- Data for Name: final_artifact_dependency; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.final_artifact_dependency (artif_dep_id, build_state_id, source_build_type_id, revision_rule, branch, src_paths) FROM stdin;
\.


--
-- Data for Name: hidden_health_item; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.hidden_health_item (item_id, user_id) FROM stdin;
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.history (build_id, agent_name, build_type_id, branch_name, build_start_time_server, build_start_time_agent, build_finish_time_server, remove_from_queue_time, queued_time, status, status_text, user_status_text, pin, is_personal, is_canceled, build_number, requestor, build_state_id, agent_type_id) FROM stdin;
\.


--
-- Data for Name: ids_group; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.ids_group (id, group_hash) FROM stdin;
\.


--
-- Data for Name: ids_group_entity_id; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.ids_group_entity_id (group_id, entity_id) FROM stdin;
\.


--
-- Data for Name: ignored_tests; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.ignored_tests (build_id, test_id, ignore_reason) FROM stdin;
\.


--
-- Data for Name: inspection_data; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_data (hash, result, severity, type_pattern, fqname, file_name, parent_fqnames, parent_type_patterns, module_name, inspection_id, is_local, used) FROM stdin;
\.


--
-- Data for Name: inspection_diff; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_diff (build_id, hash) FROM stdin;
\.


--
-- Data for Name: inspection_fixes; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_fixes (hash, hint) FROM stdin;
\.


--
-- Data for Name: inspection_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_info (id, inspection_id, inspection_name, inspection_desc, group_name) FROM stdin;
\.


--
-- Data for Name: inspection_results; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_results (build_id, hash, line) FROM stdin;
\.


--
-- Data for Name: inspection_stats; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.inspection_stats (build_id, total, new_total, old_total, errors, new_errors, old_errors) FROM stdin;
\.


--
-- Data for Name: light_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.light_history (build_id, agent_name, build_type_id, build_start_time_server, build_start_time_agent, build_finish_time_server, status, status_text, user_status_text, pin, is_personal, is_canceled, build_number, requestor, queued_time, remove_from_queue_time, build_state_id, agent_type_id, branch_name) FROM stdin;
\.


--
-- Data for Name: long_file_name; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.long_file_name (hash, file_name) FROM stdin;
\.


--
-- Data for Name: meta_file_line; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.meta_file_line (file_name, line_nr, line_text) FROM stdin;
backup.config	1	-- INTERNAL BACKUP CONFIGURATION
backup.config	2	
backup.config	3	
backup.config	4	TABLES-NOT-TO-BACKUP
backup.config	5	
backup.config	6	  db_heartbeat
backup.config	7	  build_set_tmp
backup.config	8	  backup_builds
backup.config	9	  node_events
backup.config	10	  node_tasks
backup.config	11	  node_tasks_long_value
backup.config	12	  node_locks
backup.config	13	  cloud_state_data
backup.config	14	  cloud_image_state
backup.config	15	  cloud_instance_state
backup.config	16	  cloud_instance_start
backup.config	17	  remember_me
backup.config	18	
backup.config	19	
backup.config	20	TABLES-TO-FILTER-BY-BUILDS
backup.config	21	
backup.config	22	  build_data_storage
backup.config	23	  build_labels
backup.config	24	  compiler_output
backup.config	25	  failed_tests_output
backup.config	26	  failed_tests
backup.config	27	  ignored_tests
backup.config	28	  personal_build_relative_path
backup.config	29	  stats
backup.config	30	  test_info
backup.config	31	  test_info_archive
backup.config	32	  test_metadata
backup.config	33	  inspection_results
backup.config	34	  inspection_stats
backup.config	35	  inspection_diff
backup.config	36	  duplicate_results
backup.config	37	  duplicate_diff
backup.config	38	  duplicate_stats
backup.config	39	  running
backup.config	40	  history
backup.config	41	  removed_builds_history
backup.config	42	  light_history
backup.config	43	
backup.config	44	
backup.config	45	
backup.config	46	
backup.config	47	
backup.config	48	
schema.config	1	-- TEAMCITY DATABASE SCHEMA
schema.config	2	
schema.config	3	
schema.config	4	-- Each table describes as a table name started from the first position of the line,
schema.config	5	-- and followed by its inner constructions with offset. All inner constructions
schema.config	6	-- should be written with the same offset.
schema.config	7	
schema.config	8	
schema.config	9	
schema.config	10	--                              ABBREVIATIONS
schema.config	11	--                              -------------
schema.config	12	--                              M:  mandatory (not null)
schema.config	13	--                              PK: primary key
schema.config	14	--                              AK: alternative key (unique index)
schema.config	15	--                              IE: inversion entry (non-unique index)
schema.config	16	
schema.config	17	
schema.config	18	--                              DATA TYPES
schema.config	19	--                              ----------
schema.config	20	--                              int             : 4-bytes signed integer
schema.config	21	--                              long_int        : 8-bytes signed integer
schema.config	22	--                              decimal(p,s)    : decimal number, p for precision, s for scale
schema.config	23	--                              char            : one character
schema.config	24	--                              str(n)          : string of length n, n is limited to 2000
schema.config	25	--                              long_str(n)     : long text of length n (CLOB)
schema.config	26	--                              uni_str(n)      : unicode string of length n, n is limited to 1000
schema.config	27	--                              long_uni_str(n) : long unicode text of length n (NCLOB)
schema.config	28	--                              timestamp       : date and time with 1 second precision, without time zone
schema.config	29	--                              boolean         : boolean
schema.config	30	
schema.config	31	
schema.config	32	--                              FIELD OPTIONS
schema.config	33	--                              -------------
schema.config	34	--                              default <value> : specifies default value
schema.config	35	--                              defines         : defines value of it's domain
schema.config	36	--                              refers          : references to domain values defines in other tables
schema.config	37	--                              serial          : means that this field gets it values from a sequence
schema.config	38	
schema.config	39	
schema.config	40	--                              DOMAIN OPTIONS
schema.config	41	--                              -------------
schema.config	42	--                              persistable     : these domains store sequence id in domain_sequence table
schema.config	43	--                                                It's possible to specify the number of ids reserved by a server at once
schema.config	44	--                                                using CachingNumericIdSequences.DEFAULT_IDS_COUNTS_TO_RESERVE_PER_DOMAIN
schema.config	45	--                                                Default value is 0 meaning that nodes will access the database every time they need a new id
schema.config	46	
schema.config	47	
schema.config	48	-- Notes:
schema.config	49	-- 1. The first table should be the 'db_version', the last table should be the 'server'.
schema.config	50	-- 2. Tables are grouped by categories. Please put new one into a proper category.
schema.config	51	-- 3. All names should be written in lower case; national characters are not allowed.
schema.config	52	-- 4. Names of temporary tables are suffixed with '$'.
schema.config	53	-- 5. Ensure that there are no tab characters at beginning of lines.
schema.config	54	-- 6. Unicode string and text types are used since 9.0.
schema.config	55	-- 7. BLOBs (strings more than 4000 or unicode strings more than 2000) must be the last fields.
schema.config	56	-- 8. In this file allows at most 160 character per line.
schema.config	57	
schema.config	58	
schema.config	59	
schema.config	60	-- DOMAINS
schema.config	61	
schema.config	62	config_id:                 domain of str(80)
schema.config	63	group_id:                  domain of str(80)
schema.config	64	teamcity_username:         domain of uni_str(191) -- see jetbrains.buildServer.serverSide.versioning.converters.RecreateUsersTableConverter
schema.config	65	user_id:                   domain of long_int persistable
schema.config	66	user_role_id:              domain of str(80)
schema.config	67	user_notific_rule_id:      domain of long_int persistable
schema.config	68	group_notific_rule_id:     domain of long_int persistable
schema.config	69	subject_property_key:      domain of str(80)
schema.config	70	agent_pool_id:             domain of int persistable
schema.config	71	agent_id:                  domain of int persistable
schema.config	72	agent_type_id:             domain of int persistable
schema.config	73	project_ext_id:            domain of str(240)
schema.config	74	bt_ext_id:                 domain of str(240)
schema.config	75	vcs_root_ext_id:           domain of str(240)
schema.config	76	project_int_id:            domain of str(80)
schema.config	77	bt_int_id:                 domain of str(80)  -- for both build_type and build_template
schema.config	78	ids_group_id:              domain of int
schema.config	79	vcs_root_int_id:           domain of int persistable
schema.config	80	vcs_root_instance_id:      domain of int
schema.config	81	vcs_revision:              domain of str(200)
schema.config	82	modification_hash:         domain of str(40)
schema.config	83	modification_id:           domain of long_int persistable
schema.config	84	personal_modification_id:  domain of long_int persistable
schema.config	85	promotion_id:              domain of long_int persistable
schema.config	86	build_id:                  domain of long_int persistable
schema.config	87	test_name_hash:            domain of long_int
schema.config	88	test_metadata_type_key:    domain of int
schema.config	89	test_metadata_key:         domain of long_int persistable
schema.config	90	problem_id:                domain of int
schema.config	91	problem_type:              domain of str(80)
schema.config	92	problem_identity:          domain of str(60)
schema.config	93	mute_id:                   domain of int persistable
schema.config	94	file_name_hash:            domain of str(40)
schema.config	95	tag_phrase:                domain of uni_str(255)
schema.config	96	metric_hash:               domain of long_int
schema.config	97	server_health_item_id:     domain of long_int persistable
schema.config	98	audit_comment_id:          domain of long_int persistable
schema.config	99	cleanup_proc_id:           domain of long_int persistable
schema.config	100	inspection_id_hash:        domain of long_int
schema.config	101	inspection_id_str:         domain of str(255)
schema.config	102	inspection_data_hash:      domain of long_int
schema.config	103	duplicate_file_id:         domain of long_int
schema.config	104	duplicate_file_name:       domain of str(255)
schema.config	105	duplicate_result_id:       domain of long_int
schema.config	106	duplicate_result_hash:     domain of int
schema.config	107	dependency_id:             domain of str(40)
schema.config	108	custom_data_body_id:       domain of long_int
schema.config	109	permanent_token_id:        domain of long_int persistable
schema.config	110	node_task_id:              domain of int persistable
schema.config	111	branch_id:                 domain of long_int persistable
schema.config	112	branch_name_hash:          domain of str(80)
schema.config	113	branch_insertion_time:     domain of long_int
schema.config	114	
schema.config	115	
schema.config	116	-- TABLES THAT CONTAIN PREDEFINED IMMUTABLE DATA
schema.config	117	
schema.config	118	db_version:                     table
schema.config	119	
schema.config	120	  version_number:               int M
schema.config	121	  version_time:                 timestamp M
schema.config	122	  incompatible_change:          boolean M default 1
schema.config	123	
schema.config	124	  db_version_pk:                PK (version_number)
schema.config	125	
schema.config	126	
schema.config	127	meta_file_line:                 table
schema.config	128	
schema.config	129	  file_name:                    str(15)  M  -- metadata file name with suffix
schema.config	130	  line_nr:                      int      M  -- line number, started with 1
schema.config	225	  delete_time:                  long_int
schema.config	131	  line_text:                    str(160)    -- text of line
schema.config	132	
schema.config	133	  meta_file_line_pk:            PK (file_name, line_nr)
schema.config	134	
schema.config	135	
schema.config	136	single_row:                     table
schema.config	137	
schema.config	138	  dummy_field:                  char
schema.config	139	
schema.config	140	
schema.config	141	server_property:                table
schema.config	142	
schema.config	143	  prop_name:                    str(80) M
schema.config	144	  prop_value:                   str(256) M
schema.config	145	
schema.config	146	  server_property_pk:           PK (prop_name)
schema.config	147	
schema.config	148	
schema.config	149	
schema.config	150	
schema.config	151	-- GLOBAL TABLES (NOT RELATED TO PROJECTS OR USERS OR AGENTS)
schema.config	152	
schema.config	153	
schema.config	154	db_heartbeat:                   table
schema.config	155	
schema.config	156	  node_id:                      str(80)       -- non mandatory for backward compatibility with previous versions
schema.config	157	  starting_code:                long_int M
schema.config	158	  starting_time:                timestamp     -- not used starting with 2020.2
schema.config	159	  lock_mode:                    char M
schema.config	160	  ip_address:                   str(80)
schema.config	161	  additional_info:              str(2000)
schema.config	162	  last_time:                    timestamp     -- not used starting with 2020.2
schema.config	163	  update_interval:              long_int      -- non mandatory for backward compatibility with previous versions
schema.config	164	  uuid:                         str(80)       -- non mandatory for backward compatibility with previous versions
schema.config	165	  app_type:                     str(80)       -- non mandatory for backward compatibility with previous versions
schema.config	166	  url:                          str(128)      -- non mandatory for backward compatibility with previous versions
schema.config	167	  access_token:                 str(80)       -- not used starting with 2020.1
schema.config	168	  build_number:                 str(80)       -- non mandatory for backward compatibility with previous versions
schema.config	169	  display_version:              str(80)       -- non mandatory for backward compatibility with previous versions
schema.config	170	  responsibilities:             long_int      -- non mandatory for backward compatibility with previous versions
schema.config	171	  unix_last_time:               long_int      -- non mandatory for backward compatibility with previous versions
schema.config	172	  unix_starting_time:           long_int      -- non mandatory for backward compatibility with previous versions
schema.config	173	
schema.config	174	  db_heartbeat_pk:              PK (starting_code)
schema.config	175	
schema.config	176	
schema.config	177	backup_info:                    table
schema.config	178	
schema.config	179	  mproc_id:                     int M
schema.config	180	  file_name:                    str(1000)
schema.config	181	  file_size:                    long_int
schema.config	182	  started:                      timestamp M
schema.config	183	  finished:                     timestamp
schema.config	184	  status:                       char
schema.config	185	
schema.config	186	  backup_info_pk:               PK (mproc_id)
schema.config	187	
schema.config	188	  backup_info_file_i:           IE (file_name)
schema.config	189	
schema.config	190	
schema.config	191	backup_builds:                  table
schema.config	192	
schema.config	193	  build_id:                     build_id M
schema.config	194	
schema.config	195	  backup_builds_pk:             PK (build_id)
schema.config	196	
schema.config	197	
schema.config	198	cleanup_history:                table
schema.config	199	
schema.config	200	  proc_id:                      cleanup_proc_id M serial defines
schema.config	201	  start_time:                   long_int M
schema.config	202	  finish_time:                  long_int
schema.config	203	  interrupt_reason:             str(20)
schema.config	204	
schema.config	205	  cleanup_history_pk:           PK (proc_id)
schema.config	206	
schema.config	207	
schema.config	208	domain_sequence:               table
schema.config	209	
schema.config	210	  domain_name:                  str(100) M
schema.config	211	  last_used_value:              long_int M
schema.config	212	
schema.config	213	  domain_name_pk:               PK (domain_name)
schema.config	214	
schema.config	215	-- AGENT RELATED TABLES
schema.config	216	
schema.config	217	-- PROJECTS AND BUILD HISTORY TABLES
schema.config	218	
schema.config	219	
schema.config	220	project:                        dictionary table
schema.config	221	
schema.config	222	  int_id:                       project_int_id   M  serial   defines
schema.config	223	  config_id:                    config_id        M           defines
schema.config	224	  origin_project_id:            project_int_id
schema.config	226	
schema.config	227	  project_pk:                   PK (int_id)
schema.config	228	  project_ak:                   AK (config_id)               stable
schema.config	229	
schema.config	230	
schema.config	231	build_type:                     dictionary table
schema.config	232	
schema.config	233	  int_id:                       bt_int_id        M  serial   defines
schema.config	234	  config_id:                    config_id        M           defines
schema.config	235	  origin_project_id:            project_int_id
schema.config	236	  delete_time:                  long_int
schema.config	237	
schema.config	238	  build_type_pk:                PK (int_id)
schema.config	239	  build_type_ak:                AK (config_id)               stable
schema.config	240	
schema.config	241	
schema.config	242	vcs_root:                       dictionary table
schema.config	243	
schema.config	244	  int_id:                       vcs_root_int_id  M  serial   defines
schema.config	245	  config_id:                    config_id        M           defines
schema.config	246	  origin_project_id:            project_int_id
schema.config	247	  delete_time:                  long_int
schema.config	248	
schema.config	249	  vcs_root_pk:                  PK (int_id)
schema.config	250	  vcs_root_ak:                  AK (config_id)               stable
schema.config	251	
schema.config	252	
schema.config	253	project_mapping:                table
schema.config	254	
schema.config	255	  int_id:                       project_int_id M       refers
schema.config	256	  ext_id:                       project_ext_id M       defines
schema.config	257	  main:                         boolean M
schema.config	258	
schema.config	259	  project_mapping_pk:           PK (int_id, ext_id)
schema.config	260	  project_mapping_ak:           AK (ext_id)
schema.config	261	
schema.config	262	
schema.config	263	build_type_mapping:             table
schema.config	264	
schema.config	265	  int_id:                       bt_int_id M            refers
schema.config	266	  ext_id:                       bt_ext_id M            defines
schema.config	267	  main:                         boolean M
schema.config	268	
schema.config	269	  build_type_mapping_pk:        PK (int_id, ext_id)
schema.config	270	  build_type_mapping_ak:        AK (ext_id)
schema.config	271	
schema.config	272	
schema.config	273	vcs_root_mapping:               table
schema.config	274	
schema.config	275	  int_id:                       vcs_root_int_id M      defines -- refers    TODO return refers when vcs_root table is populated
schema.config	276	  ext_id:                       vcs_root_ext_id M      defines
schema.config	277	  main:                         boolean M
schema.config	278	
schema.config	279	  vcs_root_mapping_pk:          PK (int_id, ext_id)
schema.config	280	  vcs_root_mapping_ak:          AK (ext_id)
schema.config	281	
schema.config	282	
schema.config	283	build_type_counters:            table
schema.config	284	   build_type_id:               bt_int_id M
schema.config	285	   counter:                     long_int M
schema.config	286	
schema.config	287	   build_type_counters_pk:      PK(build_type_id)
schema.config	288	
schema.config	289	agent_pool:                     table
schema.config	290	
schema.config	291	  agent_pool_id:                agent_pool_id M  serial defines   -- 0 means the Default Pool
schema.config	292	  agent_pool_name:              uni_str(191)            defines   -- see jetbrains.buildServer.serverSide.agentPools.AgentPoolConstants.MAX_POOL_NAME_LENGTH
schema.config	293	  min_agents:                   int
schema.config	294	  max_agents:                   int                       -- -1 means unlimited
schema.config	295	  owner_project_id:             project_int_id          refers
schema.config	296	
schema.config	297	  agent_pool_id_pk:             PK (agent_pool_id)
schema.config	298	
schema.config	299	
schema.config	300	agent_type:                     table
schema.config	301	
schema.config	302	  agent_type_id:                agent_type_id M  serial defines
schema.config	303	  agent_pool_id:                agent_pool_id M         refers
schema.config	304	  cloud_code:                   str(6) M
schema.config	305	  profile_id:                   str(30) M
schema.config	306	  image_id:                     str(60) M
schema.config	307	  policy:                       int M       -- 1: all configurations, 2: selected ones only
schema.config	308	
schema.config	309	  agent_type_pk:                PK (agent_type_id)
schema.config	310	  agent_type_ak:                AK (cloud_code, profile_id, image_id)
schema.config	311	  agent_type_pool_i:            IE (agent_pool_id)
schema.config	312	
schema.config	313	
schema.config	314	agent_type_info:                table
schema.config	315	
schema.config	316	  agent_type_id:                agent_type_id M  refers
schema.config	317	  os_name:                      str(60) M
schema.config	318	  cpu_rank:                     int
schema.config	319	  created_timestamp:            timestamp
schema.config	320	  modified_timestamp:           timestamp
schema.config	321	
schema.config	322	  agent_type_info_pk:           PK (agent_type_id)
schema.config	323	
schema.config	324	
schema.config	325	agent_type_runner:              table
schema.config	326	
schema.config	327	  agent_type_id:                agent_type_id M  refers
schema.config	328	  runner:                       str(250) M
schema.config	329	
schema.config	330	  agent_type_runner_pk:         PK (agent_type_id, runner)
schema.config	331	
schema.config	332	
schema.config	333	agent_type_vcs:                 table
schema.config	334	
schema.config	335	  agent_type_id:                agent_type_id M  refers
schema.config	336	  vcs:                          str(250) M
schema.config	337	
schema.config	338	  agent_type_vcs_pk:            PK (agent_type_id, vcs)
schema.config	339	
schema.config	340	
schema.config	341	agent_type_param:               table
schema.config	342	
schema.config	343	  agent_type_id:                agent_type_id M  refers
schema.config	344	  param_kind:                   char M
schema.config	345	  param_name:                   str(160) M
schema.config	346	  param_value:                  uni_str(2000)
schema.config	347	
schema.config	348	  agent_type_param_pk:          PK (agent_type_id, param_kind, param_name)
schema.config	349	
schema.config	350	
schema.config	351	agent:                          table
schema.config	352	
schema.config	353	  id:                           agent_id M       serial defines
schema.config	354	  name:                         uni_str(256) M               defines
schema.config	355	  host_addr:                    str(80) M
schema.config	356	  port:                         int M
schema.config	357	  agent_type_id:                int M
schema.config	358	  status:                       int
schema.config	359	  authorized:                   int
schema.config	360	  registered:                   int
schema.config	361	  registration_timestamp:       long_int
schema.config	362	  last_binding_timestamp:       long_int
schema.config	363	  unregistered_reason:          str(256)
schema.config	364	  authorization_token:          str(32)
schema.config	365	  status_to_restore:            int
schema.config	366	  status_restoring_timestamp:   long_int
schema.config	367	  version:                      str(80)
schema.config	368	  plugins_version:              str(80)
schema.config	369	
schema.config	370	  agent_pk:                     PK (id)
schema.config	371	  agent_name_ui:                AK (name)
schema.config	372	
schema.config	373	  agent_host_address:           IE (host_addr)
schema.config	374	  agent_authorization_token:    IE (authorization_token)
schema.config	375	  agent_agent_type_id:          IE (agent_type_id)
schema.config	376	
schema.config	377	cloud_image_state:              table
schema.config	378	  project_id:                   project_int_id M        refers
schema.config	379	  profile_id:                   str(30) M
schema.config	380	  image_id:                     str(80) M
schema.config	381	  name:                         str(80) M
schema.config	382	
schema.config	383	  cloud_image_state_pk:         PK (project_id, profile_id, image_id)
schema.config	384	
schema.config	385	cloud_instance_state:           table
schema.config	386	  project_id:                   project_int_id M        refers
schema.config	387	  profile_id:                   str(30) M
schema.config	388	  image_id:                     str(80) M
schema.config	389	  instance_id:                  str(80) M
schema.config	390	  name:                         str(80) M
schema.config	391	  last_update:                  timestamp M
schema.config	392	  status:                       str(30) M
schema.config	393	  start_time:                   timestamp M
schema.config	394	  network_identity:             str(80)
schema.config	395	  is_expired:                   boolean
schema.config	396	  agent_id:                     agent_id
schema.config	397	
schema.config	398	  cloud_instance_pk:            PK (project_id, profile_id, image_id, instance_id)
schema.config	399	
schema.config	400	cloud_state_data:               table
schema.config	401	  project_id:                   project_int_id M        refers
schema.config	402	  profile_id:                   str(30) M
schema.config	403	  image_id:                     str(80) M
schema.config	404	  instance_id:                  str(80) M
schema.config	405	  data:                         uni_str(2000) M
schema.config	406	
schema.config	407	  cloud_state_data_pk:          PK (project_id, profile_id, image_id, instance_id)
schema.config	408	
schema.config	409	--deprecated table
schema.config	410	cloud_started_instance:         table
schema.config	411	
schema.config	412	  profile_id:                   str(30) M
schema.config	413	  cloud_code:                   str(6) M
schema.config	414	  image_id:                     str(80) M
schema.config	415	  instance_id:                  str(80) M
schema.config	416	  last_update:                  timestamp M
schema.config	417	
schema.config	418	  cloud_started_instance_pk:    PK (profile_id, cloud_code, image_id, instance_id)
schema.config	419	
schema.config	420	
schema.config	421	cloud_image_without_agent:      table
schema.config	422	
schema.config	423	  profile_id:                   str(30) M
schema.config	424	  cloud_code:                   str(6) M
schema.config	425	  image_id:                     str(80) M
schema.config	426	  last_update:                  timestamp M
schema.config	427	
schema.config	428	  cloud_image_without_agent_pk: PK (profile_id, cloud_code, image_id)
schema.config	429	
schema.config	430	
schema.config	431	
schema.config	432	
schema.config	433	-- USERS DEFINITION TABLES
schema.config	434	
schema.config	435	
schema.config	436	usergroups:                     dictionary table
schema.config	437	
schema.config	438	  group_id:                     group_id      M      defines
schema.config	439	  name:                         uni_str(255)  M      defines
schema.config	440	  description:                  uni_str(2000)
schema.config	441	
schema.config	442	  usergroups_pk:                PK (group_id)        stable
schema.config	443	  usergroups_ak:                AK (name)
schema.config	444	
schema.config	445	
schema.config	446	usergroup_property:             table
schema.config	447	
schema.config	448	  group_id:                     group_id M               refers
schema.config	449	  prop_key:                     subject_property_key  M  defines
schema.config	450	  prop_value:                   uni_str(2000)
schema.config	451	
schema.config	452	  usergroup_property_pk:        PK (group_id, prop_key)
schema.config	453	
schema.config	454	
schema.config	455	users:                          dictionary table
schema.config	456	
schema.config	457	  id:                           user_id    M  serial defines  -- user's surrogate id
schema.config	458	  username:                     teamcity_username  M defines  -- user's natural id, in lower case
schema.config	459	  password:                     str(128)                      -- enciphered password
schema.config	460	  name:                         uni_str(256)                  -- user's real name
schema.config	461	  email:                        str(256)
schema.config	462	  last_login_timestamp:         long_int
schema.config	463	  algorithm:                    str(20)
schema.config	464	
schema.config	465	  user_pk:                      PK (id)
schema.config	466	  user_ak:                      AK (username) stable
schema.config	467	
schema.config	468	
schema.config	469	user_property:                  table
schema.config	470	
schema.config	471	  user_id:                      user_id                M  refers
schema.config	472	  prop_key:                     subject_property_key   M  defines
schema.config	473	  prop_value:                   uni_str(2000)
schema.config	474	  locase_value_hash:            long_int               -- store standart javas hashcode of value in lower case (i.e. prop_value.toLowerCase().hashCode())
schema.config	475	
schema.config	476	  user_property_pk:             PK (user_id, prop_key)
schema.config	477	  user_property_key_value_idx:  IE (prop_key, locase_value_hash)
schema.config	478	
schema.config	479	
schema.config	480	user_attribute:                 table
schema.config	481	
schema.config	482	  user_id:                      user_id                M  refers
schema.config	483	  attr_key:                     str(80)                M
schema.config	484	  attr_value:                   uni_str(2000)
schema.config	485	  locase_value_hash:            long_int               -- stores java.lang.String hashcode of the value in lower case (attr_value.toLowerCase().hashCode())
schema.config	486	
schema.config	487	  user_attr_pk:                 PK (user_id, attr_key)
schema.config	488	  user_attr_key_value_idx:      IE (attr_key, locase_value_hash)
schema.config	489	
schema.config	490	
schema.config	491	user_blocks:                    table
schema.config	492	
schema.config	493	  user_id:                      user_id M  refers
schema.config	494	  block_type:                   str(80) M
schema.config	495	  state:                        str(2048)
schema.config	496	
schema.config	497	  user_blocks_pk:               PK (user_id, block_type)
schema.config	498	
schema.config	499	
schema.config	500	user_notification_events:       table
schema.config	501	
schema.config	502	  id:                           user_notific_rule_id M  serial defines
schema.config	503	  user_id:                      user_id M                      refers
schema.config	504	  notificator_type:             str(20) M
schema.config	505	  events_mask:                  int M
schema.config	506	
schema.config	507	  user_notification_events_pk:  PK (id)
schema.config	508	
schema.config	509	  notification_events_notifier: IE (notificator_type)
schema.config	703	
schema.config	510	  notification_events_user_id:  IE (user_id)
schema.config	511	
schema.config	512	
schema.config	513	user_watch_type:                table
schema.config	514	
schema.config	515	  rule_id:                      user_notific_rule_id M   refers
schema.config	516	  user_id:                      user_id M                refers
schema.config	517	  notificator_type:             str(20) M
schema.config	518	  watch_type:                   int M    -- values 1..5; 2 - project, 3 - build type, other - unknown
schema.config	519	  watch_value:                  str(80) M
schema.config	520	  order_num:                    long_int
schema.config	521	
schema.config	522	  user_watch_type_pk:           IE (user_id, notificator_type, watch_type, watch_value)
schema.config	523	  watch_type_rule_id:           IE (rule_id)
schema.config	524	
schema.config	525	
schema.config	526	user_notification_data:         table
schema.config	527	  user_id:                      user_id M                refers
schema.config	528	  rule_id:                      user_notific_rule_id M   refers
schema.config	529	  additional_data:              str(2000)
schema.config	530	
schema.config	531	  user_notif_data_pk:           PK (user_id, rule_id)
schema.config	532	  user_notif_data_rule_id:      IE (rule_id)
schema.config	533	
schema.config	534	
schema.config	535	usergroup_subgroups:            table
schema.config	536	
schema.config	537	  hostgroup_id:                 group_id M
schema.config	538	  subgroup_id:                  group_id M
schema.config	539	
schema.config	540	  usergroup_subgroups_pk:       PK (hostgroup_id, subgroup_id)
schema.config	541	
schema.config	542	
schema.config	543	usergroup_users:                table
schema.config	544	
schema.config	545	  group_id:                     group_id M  refers
schema.config	546	  user_id:                      user_id M   refers
schema.config	547	
schema.config	548	  usergroup_users_pk:           PK (group_id, user_id)
schema.config	549	
schema.config	550	
schema.config	551	usergroup_notification_events:  table
schema.config	552	
schema.config	553	  id:                           group_notific_rule_id M  serial defines
schema.config	554	  group_id:                     group_id M                      refers
schema.config	555	  notificator_type:             str(20) M
schema.config	556	  events_mask:                  int M
schema.config	557	
schema.config	558	  usergroup_notific_evnts_pk:   PK (id)
schema.config	559	
schema.config	560	  usergroup_events_notifier:    IE (notificator_type)
schema.config	561	  usergroup_events_group_id:    IE (group_id)
schema.config	562	
schema.config	563	
schema.config	564	usergroup_watch_type:           table
schema.config	565	
schema.config	566	  rule_id:                      group_notific_rule_id M refers
schema.config	567	  group_id:                     group_id M              refers
schema.config	568	  notificator_type:             str(20) M
schema.config	569	  watch_type:                   int M    -- values 1..5; 2 - project, 3 - build type, other - unknown
schema.config	570	  watch_value:                  str(80) M
schema.config	571	  order_num:                    long_int
schema.config	572	
schema.config	573	  usergroup_watch_type_pk:      IE (group_id, notificator_type, watch_type, watch_value)
schema.config	574	  group_watch_type_rule_id:     IE (rule_id)
schema.config	575	
schema.config	576	
schema.config	577	usergroup_notification_data:    table
schema.config	578	
schema.config	579	  group_id:                     group_id M               refers
schema.config	580	  rule_id:                      group_notific_rule_id M  refers
schema.config	581	  additional_data:              str(2000)
schema.config	582	
schema.config	583	  group_notif_data_pk:          PK (group_id, rule_id)
schema.config	584	  group_notif_data_rule_id:     IE (rule_id)
schema.config	585	
schema.config	586	
schema.config	587	remember_me:                    table
schema.config	588	
schema.config	589	  user_key:                     str(65) M
schema.config	590	  secure:                       long_int M
schema.config	591	
schema.config	592	  remember_me_uk_secure_idx:    IE (user_key, secure)
schema.config	593	  remember_me_secure_idx:       IE (secure)
schema.config	594	
schema.config	595	
schema.config	596	permanent_tokens:               table
schema.config	597	
schema.config	598	  id:                           permanent_token_id M serial defines
schema.config	599	  identifier:                   str(36) M
schema.config	600	  name:                         uni_str(128) M
schema.config	601	  user_id:                      user_id M refers
schema.config	602	  hashed_value:                 str(255) M
schema.config	603	  expiration_time:              long_int
schema.config	604	  creation_time:                long_int
schema.config	605	  last_access_time:             long_int
schema.config	606	  last_access_info:             str(255)
schema.config	607	  type:                         int M default 0
schema.config	608	
schema.config	609	  permanent_token_pk:           PK (id)
schema.config	610	  token_user_id_name_ak:        AK (user_id, name)
schema.config	611	  token_identifier_ak:          AK (identifier)
schema.config	612	  permanent_t_exp_t_idx:        IE (expiration_time)
schema.config	613	
schema.config	614	
schema.config	615	permanent_token_permissions:    table
schema.config	616	
schema.config	617	  id:                           permanent_token_id M refers
schema.config	618	  project_id:                   project_int_id
schema.config	619	  permission:                   int M
schema.config	620	
schema.config	621	  token_permissions_pk:         PK(id, project_id, permission)
schema.config	622	  permanent_t_p_pr_id_idx:      IE (project_id)
schema.config	623	
schema.config	624	
schema.config	625	-- COMMON DICTIONARY TABLES
schema.config	626	
schema.config	627	
schema.config	628	long_file_name:                 dictionary table
schema.config	629	
schema.config	630	  hash:                         file_name_hash M       defines
schema.config	631	  file_name:                    long_uni_str(16000) M  defines
schema.config	632	
schema.config	633	  long_file_name_pk:            PK (hash) stable
schema.config	634	
schema.config	635	
schema.config	636	test_names:                     dictionary table
schema.config	637	
schema.config	638	  id:                           test_name_hash M       defines
schema.config	639	  test_name:                    uni_str(1024) M         defines
schema.config	640	  order_num:                    long_int
schema.config	641	
schema.config	642	  test_names_pk:                PK (id) stable
schema.config	643	  order_num_idx:                IE (order_num)
schema.config	644	
schema.config	645	
schema.config	646	data_storage_dict:              dictionary table
schema.config	647	
schema.config	648	  metric_id:                    metric_hash M          defines
schema.config	649	  value_type_key:               str(200)               defines
schema.config	650	
schema.config	651	  metric_id_pk:                 PK (metric_id)         stable
schema.config	652	  value_type_key_index:         AK (value_type_key)    stable
schema.config	653	
schema.config	654	
schema.config	655	problem:                        dictionary table
schema.config	656	
schema.config	657	  problem_id:                   problem_id       M serial defines
schema.config	658	  problem_type:                 problem_type     M
schema.config	659	  problem_identity:             problem_identity M
schema.config	660	
schema.config	661	  problem_pk:                   PK (problem_id)
schema.config	662	  problem_ak:                   AK (problem_type, problem_identity) stable
schema.config	663	
schema.config	664	
schema.config	665	agent_type_bt_access:           table
schema.config	666	
schema.config	667	  agent_type_id:                agent_type_id M        refers
schema.config	668	  build_type_id:                bt_int_id M            refers
schema.config	669	
schema.config	670	  agent_type_bt_access_pk:      PK (agent_type_id, build_type_id)
schema.config	671	  agent_type_bt_access_bt_i:    IE (build_type_id)
schema.config	672	
schema.config	673	
schema.config	674	user_projects_visibility:       table
schema.config	675	
schema.config	676	  user_id:                      user_id M              refers
schema.config	677	  project_int_id:               project_int_id M       refers
schema.config	678	  visible:                      int M
schema.config	679	
schema.config	680	  user_projects_visibility_pk:  PK (user_id, project_int_id)
schema.config	681	  user_projects_visibility_i:   IE (project_int_id)
schema.config	682	
schema.config	683	
schema.config	684	user_projects_order:            table
schema.config	685	
schema.config	686	  user_id:                      user_id M              refers
schema.config	687	  project_int_id:               project_int_id M       refers
schema.config	688	  ordernum:                     int
schema.config	689	
schema.config	690	  user_projects_order_pk:       PK (user_id, project_int_id)
schema.config	691	  user_projects_order_i:        IE (project_int_id)
schema.config	692	
schema.config	693	user_build_types_order:         table
schema.config	694	
schema.config	695	  user_id:                      user_id M              refers
schema.config	696	  project_int_id:               project_int_id M       refers
schema.config	697	  bt_int_id:                    bt_int_id M            refers
schema.config	698	  ordernum:                     int M
schema.config	699	  visible:                      int M
schema.config	700	
schema.config	701	  user_bt_order_pk:             PK (user_id, project_int_id, bt_int_id)
schema.config	702	  user_build_types_order_i:     IE (project_int_id)
schema.config	704	vcs_root_instance:              table
schema.config	705	
schema.config	706	  id:                           vcs_root_instance_id M  serial defines
schema.config	707	  parent_id:                    vcs_root_int_id M              refers
schema.config	708	  settings_hash:                long_int M
schema.config	709	  body:                         long_str(16384)
schema.config	710	
schema.config	711	  vcs_root_instance_pk:         PK (id)
schema.config	712	  vcs_root_instance_parent_idx: IE (parent_id, settings_hash)
schema.config	713	
schema.config	714	repository_state:               table
schema.config	715	
schema.config	716	  vcs_root_id:                  vcs_root_instance_id M  refers          -- vcs root instance id
schema.config	717	  node_id:                      str(80) M                               -- id of the last node which updated this state
schema.config	718	  update_time:                  long_int M                              -- timestamp when this state was updated
schema.config	719	
schema.config	720	  repo_state_vcs_root_idx:      AK (vcs_root_id)
schema.config	721	
schema.config	722	branch_name_dict:              dictionary table
schema.config	723	
schema.config	724	  id:                          branch_id M serial defines
schema.config	725	  branch_name:                 uni_str(2000) M          -- branch name
schema.config	726	  branch_name_hash:            branch_name_hash M       -- sha1 hash of the branch name
schema.config	727	  insertion_time:              branch_insertion_time M  -- time when the branch name was inserted into the table
schema.config	728	
schema.config	729	  branch_name_pk:              PK (id)
schema.config	730	  branch_name_idx:             AK (branch_name_hash, insertion_time) stable
schema.config	731	
schema.config	732	repository_state_branches:      table
schema.config	733	
schema.config	734	  vcs_root_id:                  vcs_root_instance_id M refers   -- vcs root instance id
schema.config	735	  branch_id:                    branch_id M refers              -- id of a branch name from branch_name_dict table
schema.config	736	  revision:                     str(256) M                      -- branch revision
schema.config	737	  creation_time:                long_int M                      -- branch create timestamp if known, otherwise 0
schema.config	738	
schema.config	739	  repo_state_branches_idx:      AK (vcs_root_id, branch_id)
schema.config	740	
schema.config	741	agent_pool_project:             table
schema.config	742	
schema.config	743	  agent_pool_id:                agent_pool_id M         refers
schema.config	744	  project_int_id:               project_int_id M        refers
schema.config	745	
schema.config	746	  agent_pool_project_pk:        PK (agent_pool_id, project_int_id)
schema.config	747	
schema.config	748	
schema.config	749	vcs_history:                    table
schema.config	750	
schema.config	751	  modification_id:              modification_id M       serial defines
schema.config	752	  user_name:                    uni_str(255)
schema.config	753	  description:                  uni_str(2000)
schema.config	754	  change_date:                  long_int
schema.config	755	  register_date:                long_int
schema.config	756	  vcs_root_id:                  vcs_root_instance_id           refers
schema.config	757	  changes_count:                int
schema.config	758	  version:                      vcs_revision M
schema.config	759	  display_version:              str(200)
schema.config	760	
schema.config	761	  vcs_history_pk:               PK (modification_id)
schema.config	762	
schema.config	763	  vcs_history_root_id_mod_id_i: IE (vcs_root_id, modification_id)
schema.config	764	  vcs_history_date_i:           IE (register_date)
schema.config	765	
schema.config	766	
schema.config	767	duplicate_vcs_modification:    table
schema.config	768	  modification_id:              modification_id M              refers
schema.config	769	  orig_modification_id:         modification_id M              refers
schema.config	770	  register_date:                long_int M
schema.config	771	  vcs_root_id:                  vcs_root_instance_id M         refers
schema.config	772	  changes_count:                int
schema.config	773	
schema.config	774	  duplicate_mods_pk:            PK (modification_id)
schema.config	775	  duplicate_mods_r_id_mod_id_i: IE (vcs_root_id, modification_id)
schema.config	776	  duplicate_mods_mod_id_date_i: IE (modification_id, register_date)
schema.config	777	  duplicate_mods_orig_mod_id_i: IE (orig_modification_id)
schema.config	778	
schema.config	779	
schema.config	780	vcs_change:                     table
schema.config	781	
schema.config	782	  modification_id:              modification_id M   refers
schema.config	783	  file_num:                     int M                           -- number of file in the change
schema.config	784	  vcs_file_name:                uni_str(2000) M                 -- first 2000 characters if the name is long
schema.config	785	  vcs_file_name_hash:           file_name_hash      refers
schema.config	786	  relative_file_name_pos:       int
schema.config	787	  relative_file_name:           uni_str(2000)
schema.config	788	  relative_file_name_hash:      file_name_hash      refers
schema.config	789	  change_type:                  int M
schema.config	790	  change_name:                  str(64)
schema.config	791	  before_revision:              vcs_revision
schema.config	792	  after_revision:               vcs_revision
schema.config	793	
schema.config	794	  vcs_change_pk:                PK (modification_id, file_num)
schema.config	795	
schema.config	796	
schema.config	797	personal_vcs_history:           table
schema.config	798	
schema.config	799	  modification_id:              personal_modification_id M serial defines
schema.config	800	  modification_hash:            modification_hash M               defines
schema.config	801	  user_id:                      user_id           M               refers
schema.config	802	  description:                  uni_str(2000)
schema.config	803	  change_date:                  long_int          M
schema.config	804	  changes_count:                int               M
schema.config	805	  commit_changes:               int
schema.config	806	  status:                       int               M default 0
schema.config	807	  scheduled_for_deletion:       boolean           M default 0
schema.config	808	
schema.config	809	  personal_vcs_history_pk:      PK (modification_id)
schema.config	810	  personal_vcs_history_ak:      AK (modification_hash)      stable
schema.config	811	  personal_vcs_history_user_i:  IE (user_id)
schema.config	812	
schema.config	813	
schema.config	814	personal_vcs_change:            table
schema.config	815	
schema.config	816	  modification_id:              personal_modification_id M  refers
schema.config	817	  file_num:                     int M                               -- number of file in the change
schema.config	818	  vcs_file_name:                uni_str(2000) M                     -- first 2000 characters if the name is long
schema.config	819	  vcs_file_name_hash:           file_name_hash              refers
schema.config	820	  relative_file_name_pos:       int
schema.config	821	  relative_file_name:           uni_str(2000)
schema.config	822	  relative_file_name_hash:      file_name_hash              refers
schema.config	823	  change_type:                  int M
schema.config	824	  change_name:                  str(64)
schema.config	825	  before_revision:              vcs_revision
schema.config	826	  after_revision:               vcs_revision
schema.config	827	
schema.config	828	  personal_vcs_changes_pk:      PK (modification_id, file_num)
schema.config	829	
schema.config	830	
schema.config	831	vcs_changes_graph:              table
schema.config	832	
schema.config	833	  child_modification_id:        modification_id M   refers
schema.config	834	  child_revision:               vcs_revision M
schema.config	835	  parent_num:                   int M
schema.config	836	  parent_modification_id:       modification_id     refers
schema.config	837	  parent_revision:              vcs_revision M
schema.config	838	
schema.config	839	  vcs_changes_graph_pk:         PK (child_modification_id, parent_num)
schema.config	840	  vcs_changes_graph_parent_i:   IE (parent_modification_id)
schema.config	841	
schema.config	842	
schema.config	843	vcs_change_attrs:               table
schema.config	844	
schema.config	845	  modification_id:              modification_id M   refers
schema.config	846	  attr_name:                    str(200) M
schema.config	847	  attr_value:                   str(1000)
schema.config	848	
schema.config	849	  vcs_change_attrs_pk:          PK (modification_id, attr_name)
schema.config	850	
schema.config	851	
schema.config	852	vcs_root_first_revision:        table
schema.config	853	
schema.config	854	  build_type_id:                bt_int_id M        refers
schema.config	855	  parent_root_id:               vcs_root_int_id M  refers
schema.config	856	  settings_hash:                long_int M
schema.config	857	  vcs_revision:                 vcs_revision M
schema.config	858	
schema.config	859	  vcs_root_first_revision_pk:   PK (build_type_id, parent_root_id, settings_hash)
schema.config	860	
schema.config	861	
schema.config	862	vcs_username:                   table
schema.config	863	
schema.config	864	  user_id:                      user_id M refers
schema.config	865	  vcs_name:                     str(60) M
schema.config	866	  parent_vcs_root_id:           vcs_root_int_id M refers
schema.config	867	  order_num:                    int M
schema.config	868	  username:                     uni_str(255) M
schema.config	869	
schema.config	870	  vcs_username_pk:              PK (user_id, vcs_name, parent_vcs_root_id, order_num)
schema.config	871	  vcs_username_ak:              AK (user_id, vcs_name, parent_vcs_root_id, username)
schema.config	872	  vcs_username_user_ie:         IE (vcs_name, parent_vcs_root_id, username)
schema.config	873	
schema.config	874	
schema.config	875	build_state:                    table
schema.config	876	
schema.config	877	  id:                           promotion_id M   serial defines
schema.config	878	  build_id:                     build_id         defines
schema.config	1144	  artif_dep_id:                 dependency_id M
schema.config	879	  build_type_id:                bt_int_id        refers
schema.config	880	  modification_id:              modification_id  refers    -- can be null if changes checking was not performed yet,
schema.config	881	                                                           -- equals -1 if changes collecting is performed but there were no changes
schema.config	882	                                                           -- detected and there were no changes in the build configuration since its creation
schema.config	883	  chain_modification_id:        modification_id  refers    -- see docs for BuildPromotionEx.getChainModificationId()
schema.config	884	  personal_modification_id:     personal_modification_id   -- reference to personal_vcs_history, or null for regular builds
schema.config	885	  personal_user_id:             user_id                    -- owner of the modification
schema.config	886	  is_personal:                  boolean M default 0
schema.config	887	  is_canceled:                  boolean M default 0
schema.config	888	  is_changes_detached:          boolean M default 0
schema.config	889	  is_deleted:                   boolean M default 0
schema.config	890	  branch_name:                  uni_str(1024)                   -- null means no branch (master)
schema.config	891	  queued_time:                  long_int
schema.config	892	  remove_from_queue_time:       long_int
schema.config	893	
schema.config	894	  build_state_pk:               PK (id)
schema.config	895	
schema.config	896	  build_state_build_i:          IE (build_id, is_deleted, branch_name, is_personal)
schema.config	897	  build_state_build_type_i:     IE (build_type_id, is_deleted, branch_name, is_personal)
schema.config	898	  build_state_mod_i:            IE (modification_id)       -- used when modification_id sequence is initialized
schema.config	899	  build_state_puser_i:          IE (personal_user_id)
schema.config	900	  build_state_pmod_i:           IE (personal_modification_id)
schema.config	901	  build_state_rem_queue_time_i: IE (remove_from_queue_time)
schema.config	902	
schema.config	903	
schema.config	904	running:                        table
schema.config	905	
schema.config	906	  build_id:                     build_id M       serial defines
schema.config	907	  agent_id:                     agent_id                refers
schema.config	908	  build_type_id:                bt_int_id               refers
schema.config	909	  build_start_time_agent:       long_int
schema.config	910	  build_start_time_server:      long_int
schema.config	911	  build_finish_time_server:     long_int
schema.config	912	  last_build_activity_time:     long_int
schema.config	913	  is_personal:                  int
schema.config	914	  build_number:                 uni_str(512)
schema.config	915	  build_counter:                long_int
schema.config	916	  requestor:                    str(1024)
schema.config	917	  access_code:                  str(60)
schema.config	918	  queued_ag_restr_type_id:      int                             -- agent restrictor type id
schema.config	919	  queued_ag_restr_id:           int                             -- agent restrictor id
schema.config	920	  build_state_id:               promotion_id            refers
schema.config	921	  agent_type_id:                agent_type_id           refers
schema.config	922	  user_status_text:             uni_str(256)
schema.config	923	  progress_text:                uni_str(1024)
schema.config	924	  current_path_text:            long_uni_str(2048)
schema.config	925	
schema.config	926	  running_pk:                   PK (build_id)
schema.config	927	
schema.config	928	  running_state_id:             IE (build_state_id)
schema.config	929	
schema.config	930	history:                        table
schema.config	931	
schema.config	932	  build_id:                     build_id M      serial  defines
schema.config	933	  agent_name:                   uni_str(256)
schema.config	934	  build_type_id:                bt_int_id               refers
schema.config	935	  branch_name:                  uni_str(1024)
schema.config	936	  build_start_time_server:      long_int
schema.config	937	  build_start_time_agent:       long_int
schema.config	938	  build_finish_time_server:     long_int
schema.config	939	  remove_from_queue_time:       long_int
schema.config	940	  queued_time:                  long_int
schema.config	941	  status:                       int
schema.config	942	  status_text:                  uni_str(256)
schema.config	943	  user_status_text:             uni_str(256)
schema.config	944	  pin:                          int
schema.config	945	  is_personal:                  int
schema.config	946	  is_canceled:                  int
schema.config	947	  build_number:                 uni_str(512)
schema.config	948	  requestor:                    str(1024)
schema.config	949	  build_state_id:               promotion_id            refers
schema.config	950	  agent_type_id:                agent_type_id
schema.config	951	
schema.config	952	  history_build_id_pk:          PK (build_id)
schema.config	953	
schema.config	954	  history_start_time_idx:       IE (build_start_time_server)
schema.config	955	  history_finish_time_idx:      IE (build_finish_time_server)
schema.config	956	  history_bt_id_rm_from_q_time: IE (build_type_id, remove_from_queue_time)
schema.config	957	  history_remove_from_q_time_i: IE (remove_from_queue_time)
schema.config	1430	
schema.config	958	  history_build_type_id_i:      IE (build_type_id, branch_name, is_canceled, pin)
schema.config	959	  history_build_state_id_i:     IE (build_state_id)
schema.config	960	  history_agent_finish_time_i:  IE (agent_name, build_finish_time_server)
schema.config	961	  history_build_number_i:       IE (build_number)
schema.config	962	  history_agent_type_b_id_i:    IE (agent_type_id, build_id)
schema.config	963	
schema.config	964	
schema.config	965	removed_builds_history:         table
schema.config	966	
schema.config	967	  build_id:                     build_id M      serial  defines
schema.config	968	  agent_name:                   uni_str(256)
schema.config	969	  build_type_id:                bt_int_id               refers
schema.config	970	  build_start_time_server:      long_int
schema.config	971	  build_start_time_agent:       long_int
schema.config	972	  build_finish_time_server:     long_int
schema.config	973	  status:                       int
schema.config	974	  status_text:                  uni_str(256)
schema.config	975	  user_status_text:             uni_str(256)
schema.config	976	  pin:                          int
schema.config	977	  is_personal:                  int
schema.config	978	  is_canceled:                  int
schema.config	979	  build_number:                 uni_str(512)
schema.config	980	  requestor:                    str(1024)
schema.config	981	  queued_time:                  long_int
schema.config	982	  remove_from_queue_time:       long_int
schema.config	983	  build_state_id:               long_int
schema.config	984	  agent_type_id:                agent_type_id
schema.config	985	  branch_name:                  uni_str(1024)       -- null means no branch (master)
schema.config	986	
schema.config	987	  removed_builds_history_pk:     PK (build_id)
schema.config	988	
schema.config	989	  removed_b_start_time_index:    IE (build_start_time_server)
schema.config	990	  removed_b_history_finish_time: IE (build_finish_time_server)
schema.config	991	  removed_b_stats_optimized_i:   IE (build_type_id, status, is_canceled, branch_name)
schema.config	992	  removed_b_agent_buildid:       IE (agent_type_id, build_id)
schema.config	993	
schema.config	994	
schema.config	995	build_project:                  table
schema.config	996	
schema.config	997	  build_id:                     build_id M        refers
schema.config	998	  project_level:                int M
schema.config	999	  project_int_id:               project_int_id M  refers
schema.config	1000	
schema.config	1001	  build_project_pk:             PK (build_id, project_level)
schema.config	1002	  build_project_project_idx:    IE (project_int_id)
schema.config	1003	
schema.config	1004	
schema.config	1005	build_dependency:               table
schema.config	1006	
schema.config	1007	  build_state_id:               promotion_id M    refers
schema.config	1008	  depends_on:                   promotion_id M    refers
schema.config	1009	  dependency_options:           int
schema.config	1010	
schema.config	1011	  build_dependency_pk:          PK (build_state_id, depends_on)
schema.config	1012	  build_dependency_ak:          IE (depends_on, build_state_id)
schema.config	1013	
schema.config	1014	
schema.config	1015	build_attrs:                    table -- really it's promotion attrs
schema.config	1016	
schema.config	1017	  build_state_id:               promotion_id M    refers
schema.config	1018	  attr_name:                    str(70) M
schema.config	1019	  attr_value:                   uni_str(1000)
schema.config	1020	  attr_num_value:               long_int
schema.config	1021	
schema.config	1022	  build_attrs_pk:               PK (build_state_id, attr_name)
schema.config	1023	  build_attrs_num_i:            IE (attr_num_value, attr_name, build_state_id)
schema.config	1024	  build_attrs_name_idx:         IE (attr_name)
schema.config	1025	
schema.config	1026	
schema.config	1027	build_data_storage:             table
schema.config	1028	
schema.config	1029	  build_id:                     build_id M              refers
schema.config	1030	  metric_id:                    metric_hash M           refers
schema.config	1031	  metric_value:                 decimal(19,6) M
schema.config	1032	
schema.config	1033	  build_data_storage_pk:        PK (build_id, metric_id)
schema.config	1034	
schema.config	1035	
schema.config	1036	canceled_info:                  table
schema.config	1037	
schema.config	1038	  build_id:                     build_id M              refers
schema.config	1039	  user_id:                      user_id                 refers
schema.config	1040	  description:                  str(256)
schema.config	1041	  interrupt_type:               int
schema.config	1042	
schema.config	1043	  canceled_info_pk:             PK (build_id)
schema.config	1044	
schema.config	1045	failed_tests:                   table
schema.config	1046	
schema.config	1047	  test_name_id:                 test_name_hash M refers
schema.config	1048	  build_id:                     build_id M       refers
schema.config	1049	  test_id:                      int M
schema.config	1050	  ffi_build_id:                 build_id          -- null -not calculated, current build_id - first failure, other build_id > 0 - known FFI, -1 - unknown
schema.config	1051	
schema.config	1052	  failed_tests_pk2:             PK (test_name_id, build_id)
schema.config	1053	  failed_tests_build_idx2:      IE (build_id)
schema.config	1054	  failed_tests_ffi_build_idx:   IE (ffi_build_id)
schema.config	1055	
schema.config	1056	test_info:                      table
schema.config	1057	
schema.config	1058	  build_id:                     build_id M       refers
schema.config	1059	  test_id:                      int M
schema.config	1060	  test_name_id:                 test_name_hash   refers
schema.config	1061	  status:                       int
schema.config	1062	  duration:                     int M default 0
schema.config	1063	
schema.config	1064	  test_info_pk:                 PK (build_id, test_id)
schema.config	1065	  test_name_id_idx:             IE (test_name_id)
schema.config	1066	
schema.config	1067	test_info_archive:              table
schema.config	1068	
schema.config	1069	  build_id:                     build_id M       refers
schema.config	1070	  test_id:                      int M
schema.config	1071	  test_name_id:                 test_name_hash M refers
schema.config	1072	  status:                       int
schema.config	1073	  duration:                     int M default 0
schema.config	1074	
schema.config	1075	  test_info_archive_pk:         PK (build_id, test_id)
schema.config	1076	  test_archive_name_id_idx:     IE (test_name_id)
schema.config	1077	
schema.config	1078	test_metadata_dict:             dictionary table
schema.config	1079	
schema.config	1080	  key_id:                       test_metadata_key M defines
schema.config	1081	  name_digest:                  str(32) M
schema.config	1082	  name:                         uni_str(512) M
schema.config	1083	
schema.config	1084	  test_metadata_dict_pk:        PK (key_id) stable
schema.config	1085	  test_metadata_dict_ak:        AK (name_digest)
schema.config	1086	
schema.config	1087	test_metadata_types:            dictionary  table
schema.config	1088	
schema.config	1089	  type_id:                      test_metadata_type_key M defines
schema.config	1090	  name:                         str(64) M
schema.config	1091	
schema.config	1092	  test_metadata_types_pk:       PK (type_id) stable
schema.config	1093	  test_metadata_types_ak:       AK (name)
schema.config	1094	
schema.config	1095	test_metadata:                  table
schema.config	1096	
schema.config	1097	  build_id:                     build_id M       refers
schema.config	1098	  test_id:                      int M
schema.config	1099	  test_name_id:                 test_name_hash M refers
schema.config	1100	  key_id:                       test_metadata_key M refers
schema.config	1101	  type_id:                      test_metadata_type_key refers
schema.config	1102	  str_value:                    uni_str(1024)
schema.config	1103	  num_value:                    decimal(19,6)
schema.config	1104	
schema.config	1105	  test_metadata_pk:             PK (build_id, test_id, key_id)
schema.config	1106	  test_metadataname_name_idx:   IE (test_name_id)
schema.config	1107	
schema.config	1108	
schema.config	1109	build_problem:                  table
schema.config	1110	
schema.config	1111	  build_state_id:               promotion_id M    refers
schema.config	1112	  problem_id:                   problem_id M      refers
schema.config	1113	  problem_description:          long_str(4000)
schema.config	1114	
schema.config	1115	  build_problem_pk:             PK (build_state_id, problem_id)
schema.config	1116	  build_problem_id_idx:         IE (problem_id)
schema.config	1117	
schema.config	1118	
schema.config	1119	build_problem_attribute:        table
schema.config	1120	
schema.config	1121	  build_state_id:               promotion_id M    refers
schema.config	1122	  problem_id:                   problem_id M      refers
schema.config	1123	  attr_name:                    str(60) M
schema.config	1124	  attr_value:                   str(2000) M
schema.config	1125	
schema.config	1126	  build_problem_attribute_pk:   PK (build_state_id, problem_id, attr_name)
schema.config	1127	  build_problem_attr_p_id_idx:  IE (problem_id)
schema.config	1128	
schema.config	1129	
schema.config	1130	build_artifact_dependency:      table
schema.config	1131	
schema.config	1132	  artif_dep_id:                 dependency_id M
schema.config	1133	  build_state_id:               promotion_id      refers
schema.config	1134	  source_build_type_id:         bt_int_id         refers
schema.config	1135	  revision_rule:                str(80)
schema.config	1136	  branch:                       str(255)
schema.config	1137	  src_paths:                    long_str(40960)
schema.config	1138	
schema.config	1139	  build_artif_dep_state_id:     IE (build_state_id)
schema.config	1140	
schema.config	1141	
schema.config	1142	final_artifact_dependency:      table
schema.config	1143	
schema.config	1527	
schema.config	1145	  build_state_id:               promotion_id      refers
schema.config	1146	  source_build_type_id:         bt_int_id         refers
schema.config	1147	  revision_rule:                str(80)
schema.config	1148	  branch:                       str(255)
schema.config	1149	  src_paths:                    long_str(40960)
schema.config	1150	
schema.config	1151	  final_artif_dep_state_id:     IE (build_state_id)
schema.config	1152	  final_artif_dep_src_bt_id:    IE (source_build_type_id)
schema.config	1153	
schema.config	1154	
schema.config	1155	build_type_vcs_change:          table
schema.config	1156	
schema.config	1157	  modification_id:              modification_id M   refers
schema.config	1158	  build_type_id:                bt_int_id M         refers
schema.config	1159	  change_type:                  int
schema.config	1160	
schema.config	1161	  build_type_vcs_change_ui:     AK (modification_id, build_type_id)
schema.config	1162	  build_type_vcs_change_btid:   IE (build_type_id)
schema.config	1163	
schema.config	1164	
schema.config	1165	build_type_edge_relation:       table
schema.config	1166	
schema.config	1167	  child_modification_id:        modification_id M   refers
schema.config	1168	  build_type_id:                bt_int_id M         refers
schema.config	1169	  parent_num:                   int M
schema.config	1170	  change_type:                  int
schema.config	1171	
schema.config	1172	  build_type_edge_relation_pk:  PK (child_modification_id, build_type_id, parent_num)
schema.config	1173	  bt_edge_relation_btid:        IE (build_type_id)
schema.config	1174	
schema.config	1175	
schema.config	1176	ids_group:                      table
schema.config	1177	
schema.config	1178	  id:                           ids_group_id M    defines
schema.config	1179	  group_hash:                   str(80) M
schema.config	1180	
schema.config	1181	  ids_group_pk:                 PK (id)
schema.config	1182	  ids_group_hash_idx:           IE (group_hash)
schema.config	1183	
schema.config	1184	
schema.config	1185	ids_group_entity_id:            table
schema.config	1186	
schema.config	1187	  group_id:                     ids_group_id M       refers
schema.config	1188	  entity_id:                    str(160) M
schema.config	1189	
schema.config	1190	  ids_group_idx:                IE (group_id, entity_id)
schema.config	1191	  ids_group_entity_id_idx:      IE (entity_id)
schema.config	1192	
schema.config	1193	
schema.config	1194	build_type_group_vcs_change:    table
schema.config	1195	
schema.config	1196	  modification_id:              modification_id M    refers
schema.config	1197	  group_id:                     ids_group_id M       refers
schema.config	1198	  change_type:                  int
schema.config	1199	
schema.config	1200	  bt_grp_vcs_change_mod_idx:     IE (modification_id)
schema.config	1201	  bt_grp_vcs_change_grp_mod_idx: IE (group_id, modification_id)
schema.config	1202	
schema.config	1203	build_checkout_rules:           table
schema.config	1204	
schema.config	1205	  build_state_id:               promotion_id M           refers
schema.config	1206	  vcs_root_id:                  vcs_root_instance_id M   refers
schema.config	1207	  checkout_rules:               long_uni_str(16000)
schema.config	1208	
schema.config	1209	  build_checkout_rules_vid_pk:  PK (build_state_id, vcs_root_id)
schema.config	1210	  build_checkout_rules_vroot_i: IE (vcs_root_id)
schema.config	1211	
schema.config	1212	
schema.config	1213	mute_info:                      table
schema.config	1214	
schema.config	1215	  -- invariant records (they're expected to be immutable)
schema.config	1216	  mute_id:                      mute_id M         serial defines
schema.config	1217	  muting_user_id:               user_id M         refers
schema.config	1218	  muting_time:                  timestamp M
schema.config	1219	  muting_comment:               uni_str(2000)
schema.config	1220	  scope:                        char M                       -- possible values: B (build), C (configuration), P (project)
schema.config	1221	  project_int_id:               project_int_id M  refers
schema.config	1222	  build_id:                     build_id          refers
schema.config	1223	  unmute_when_fixed:            boolean
schema.config	1224	  unmute_by_time:               timestamp
schema.config	1225	
schema.config	1226	  mute_info_pk:                 PK (mute_id)
schema.config	1227	  mute_info_ak:                 AK (project_int_id, mute_id)
schema.config	1228	
schema.config	1229	
schema.config	1230	mute_info_bt:                   table
schema.config	1231	
schema.config	1232	  -- build type was muted (a detail of the mute_info), not currently muted
schema.config	1233	  mute_id:                      mute_id M         refers
schema.config	1234	  build_type_id:                bt_int_id M       refers
schema.config	1235	
schema.config	1236	  mute_info_bt_pk:              PK (mute_id, build_type_id)
schema.config	1237	  mute_info_bt_ie:              IE (build_type_id)
schema.config	1238	
schema.config	1239	
schema.config	1729	
schema.config	1240	mute_info_test:                 table
schema.config	1241	
schema.config	1242	  -- test was muted (a detail of the mute_info), not currently muted
schema.config	1243	  mute_id:                      mute_id M         refers
schema.config	1244	  test_name_id:                 test_name_hash M  refers
schema.config	1245	
schema.config	1246	  mute_info_test_pk:            PK (mute_id, test_name_id)
schema.config	1247	
schema.config	1248	
schema.config	1249	mute_test_in_proj:              table
schema.config	1250	
schema.config	1251	  -- currently muted test in project
schema.config	1252	  mute_id:                      mute_id M         refers   -- records can be reassigned from one muting to another
schema.config	1253	  project_int_id:               project_int_id M  refers
schema.config	1254	  test_name_id:                 test_name_hash M  refers
schema.config	1255	
schema.config	1256	  mute_test_in_proj_pk:         PK (mute_id, project_int_id, test_name_id)
schema.config	1257	  mute_test_in_proj_ie:         IE (project_int_id, test_name_id, mute_id)
schema.config	1258	  mute_test_in_proj_tn_ie:      IE (test_name_id)
schema.config	1259	
schema.config	1260	
schema.config	1261	mute_test_in_bt:                table
schema.config	1262	
schema.config	1263	  -- currently muted test in build configuration
schema.config	1264	  mute_id:                      mute_id M         refers   -- records can be reassigned from one muting to another
schema.config	1265	  build_type_id:                bt_int_id M       refers
schema.config	1266	  test_name_id:                 test_name_hash M  refers
schema.config	1267	
schema.config	1268	  mute_test_in_bt_pk:           PK (mute_id, build_type_id, test_name_id)
schema.config	1269	  mute_test_in_bt_ie:           IE (build_type_id, test_name_id, mute_id)
schema.config	1270	  mute_test_in_bt_tn_ie:        IE (test_name_id)
schema.config	1271	
schema.config	1272	
schema.config	1273	mute_info_problem:              table
schema.config	1274	
schema.config	1275	  mute_id:                      mute_id M         refers
schema.config	1276	  problem_id:                   problem_id M      refers
schema.config	1277	
schema.config	1278	  mute_info_problem_pk:         PK (mute_id, problem_id)
schema.config	1279	
schema.config	1280	
schema.config	1281	mute_problem_in_proj:           table
schema.config	1282	
schema.config	1283	  -- currently muted build problem in project
schema.config	1284	  mute_id:                      mute_id M         refers
schema.config	1285	  project_int_id:               project_int_id M  refers
schema.config	1286	  problem_id:                   problem_id M      refers
schema.config	1287	
schema.config	1288	  mute_problem_in_proj_pk:      PK (mute_id, project_int_id, problem_id)
schema.config	1289	  mute_problem_in_proj_ie:      IE (project_int_id, problem_id, mute_id)
schema.config	1290	
schema.config	1291	
schema.config	1292	mute_problem_in_bt:             table
schema.config	1293	
schema.config	1294	  -- currently muted build problem in build configuration
schema.config	1295	  mute_id:                      mute_id M         refers
schema.config	1296	  build_type_id:                bt_int_id M       refers
schema.config	1297	  problem_id:                   problem_id M      refers
schema.config	1298	
schema.config	1299	  mute_problem_in_bt_pk:        PK (mute_id, build_type_id, problem_id)
schema.config	1300	  mute_problem_in_bt_ie:        IE (build_type_id, problem_id, mute_id)
schema.config	1301	
schema.config	1302	
schema.config	1303	build_problem_muted:            table
schema.config	1304	
schema.config	1305	  build_state_id:               promotion_id M    refers
schema.config	1306	  problem_id:                   problem_id M      refers
schema.config	1307	  mute_id:                      mute_id           refers   -- may be null if problem internally muted during the build
schema.config	1308	
schema.config	1309	  build_problem_muted_pk:       PK (build_state_id, problem_id)
schema.config	1310	  build_problem_mute_id:        IE (mute_id)
schema.config	1311	
schema.config	1312	
schema.config	1313	test_muted:                     table
schema.config	1314	
schema.config	1315	  build_id:                     build_id M         refers
schema.config	1316	  test_name_id:                 test_name_hash M   refers
schema.config	1317	  mute_id:                      mute_id M          refers
schema.config	1318	
schema.config	1319	  test_muted_pk:                PK (build_id, test_name_id, mute_id)
schema.config	1320	  test_muted_mute_id:           IE (mute_id)
schema.config	1321	
schema.config	1322	
schema.config	1323	test_failure_rate:              table
schema.config	1324	
schema.config	1325	  build_type_id:                bt_int_id M        refers
schema.config	1326	  test_name_id:                 test_name_hash M   refers
schema.config	1327	  success_count:                int
schema.config	1328	  failure_count:                int
schema.config	1329	  last_failure_time:            long_int
schema.config	1330	
schema.config	1331	  test_failure_rate_pk:         PK (build_type_id, test_name_id)
schema.config	1332	  test_failure_rate_tn_idx:     IE (test_name_id)
schema.config	1333	
schema.config	1334	
schema.config	1335	build_queue:                    table
schema.config	1336	
schema.config	1337	  build_type_id:                bt_int_id          refers
schema.config	1338	  agent_restrictor_type_id:     int
schema.config	1339	  agent_restrictor_id:          int
schema.config	1340	  requestor:                    str(1024)
schema.config	1341	  build_state_id:               promotion_id       refers
schema.config	1342	
schema.config	1343	  build_queue_build_state_id:   IE (build_state_id)
schema.config	1344	
schema.config	1345	build_queue_order:              table
schema.config	1346	
schema.config	1347	  version:                      long_int M
schema.config	1348	  line_num:                     int M
schema.config	1349	  promotion_ids:                str(2000)
schema.config	1350	
schema.config	1351	  build_queue_order_pk:         PK (version, line_num)
schema.config	1352	
schema.config	1353	
schema.config	1354	stats:                          table
schema.config	1355	
schema.config	1356	  build_id:                     build_id M         refers
schema.config	1357	  test_count:                   int
schema.config	1358	  -- a record per build
schema.config	1359	
schema.config	1360	  stats_pk:                     PK (build_id)
schema.config	1361	
schema.config	1362	
schema.config	1363	failed_tests_output:            table
schema.config	1364	
schema.config	1365	  build_id:                     build_id M         refers
schema.config	1366	  test_id:                      int M
schema.config	1367	  problem_description:          long_str(256)
schema.config	1368	  std_output:                   long_str(40960)
schema.config	1369	  error_output:                 long_str(40960)
schema.config	1370	  stacktrace:                   long_str(40960)
schema.config	1371	  expected:                     long_str(40960)
schema.config	1372	  actual:                       long_str(40960)
schema.config	1373	
schema.config	1374	  failed_tests_output_pk:       PK (build_id, test_id)
schema.config	1375	
schema.config	1376	
schema.config	1377	compiler_output:                table
schema.config	1378	
schema.config	1379	  build_id:                     build_id           refers
schema.config	1380	  message_order:                int
schema.config	1381	  message:                      long_str(40960)
schema.config	1382	
schema.config	1383	  co_build_id_index:            IE (build_id)
schema.config	1384	
schema.config	1385	
schema.config	1386	ignored_tests:                  table
schema.config	1387	
schema.config	1388	  build_id:                     build_id           refers
schema.config	1389	  test_id:                      int
schema.config	1390	  ignore_reason:                uni_str(2000)
schema.config	1391	
schema.config	1392	  ignored_tests_build_id:       IE (build_id)
schema.config	1393	
schema.config	1394	
schema.config	1395	downloaded_artifacts:           table
schema.config	1396	
schema.config	1397	  target_build_id:              build_id           refers   -- artifact was downloaded to
schema.config	1398	  source_build_id:              build_id           refers   -- artifact was downloaded from
schema.config	1399	  download_timestamp:           long_int
schema.config	1400	  artifact_path:                long_str(8192)
schema.config	1401	
schema.config	1402	  downloaded_artifacts_source_id: IE (source_build_id)
schema.config	1403	  downloaded_artifacts_ts_id: IE (target_build_id,source_build_id)
schema.config	1404	
schema.config	1405	
schema.config	1406	build_revisions:                table
schema.config	1407	
schema.config	1408	  build_state_id:               promotion_id M          refers
schema.config	1409	  vcs_root_id:                  vcs_root_instance_id M  refers
schema.config	1410	  vcs_revision:                 vcs_revision M
schema.config	1411	  vcs_revision_display_name:    str(200)
schema.config	1412	  vcs_branch_name:              uni_str(1024)
schema.config	1413	  modification_id:              modification_id         refers
schema.config	1414	  vcs_root_type:                int
schema.config	1415	  checkout_mode:                int  -- null means the default checkout mode from a buildType, see BuildRevisionCheckoutMode
schema.config	1416	
schema.config	1417	  build_revisions_pk:           PK (build_state_id, vcs_root_id)
schema.config	1418	  build_revisions_vcs_root_i:   IE (vcs_root_id)
schema.config	1419	  build_revisions_mod_id_i:     IE (modification_id)    -- see TW-47662
schema.config	1420	
schema.config	1421	
schema.config	1422	default_build_parameters:       table
schema.config	1423	
schema.config	1424	  build_state_id:               promotion_id       refers
schema.config	1425	  param_name:                   str(2000)
schema.config	1426	  param_value:                  long_uni_str(16000)
schema.config	1427	
schema.config	1428	  def_build_params_state_id:    IE (build_state_id)
schema.config	1429	
schema.config	1431	user_build_parameters:          table
schema.config	1432	
schema.config	1433	  build_state_id:               promotion_id       refers
schema.config	1434	  param_name:                   str(2000)
schema.config	1435	  param_value:                  long_uni_str(16000)
schema.config	1436	
schema.config	1437	  user_build_params_state_id:   IE (build_state_id)
schema.config	1438	
schema.config	1439	
schema.config	1440	build_labels:                   table
schema.config	1441	
schema.config	1442	  build_id:                     build_id M              refers
schema.config	1443	  vcs_root_id:                  vcs_root_instance_id M  refers
schema.config	1444	  label:                        str(80)
schema.config	1445	  status:                       int default 0
schema.config	1446	  error_message:                str(256)
schema.config	1447	
schema.config	1448	  build_labels_pk:              PK (build_id, vcs_root_id)
schema.config	1449	  build_labels_vcs_root_i:      IE (vcs_root_id)
schema.config	1450	
schema.config	1451	
schema.config	1452	personal_build_relative_path:   table
schema.config	1453	
schema.config	1454	  build_id:                     build_id           refers
schema.config	1455	  original_path_hash:           long_int
schema.config	1456	  relative_path:                long_str(16000)
schema.config	1457	
schema.config	1458	  personal_build_relative_p_ak: AK (build_id, original_path_hash)
schema.config	1459	
schema.config	1460	
schema.config	1461	responsibilities:               table
schema.config	1462	
schema.config	1463	  problem_id:                   str(80) M          -- it's not our problem_id, it's something else
schema.config	1464	  state:                        int M
schema.config	1465	  responsible_user_id:          user_id M          refers
schema.config	1466	  reporter_user_id:             user_id            refers
schema.config	1467	  timestmp:                     long_int
schema.config	1468	  remove_method:                int M default 0
schema.config	1469	  comments:                     long_uni_str(4096)
schema.config	1470	
schema.config	1471	  responsibilities_pk:          PK (problem_id)
schema.config	1472	
schema.config	1473	  responsibilities_reporter:    IE (reporter_user_id)
schema.config	1474	  responsibilities_assignee:    IE (responsible_user_id)
schema.config	1475	
schema.config	1476	
schema.config	1477	build_state_tag:                table
schema.config	1478	
schema.config	1479	  build_state_id:               promotion_id M     refers
schema.config	1480	  tag:                          tag_phrase M
schema.config	1481	
schema.config	1482	  build_state_tag_pk:           PK (build_state_id, tag)
schema.config	1483	  build_state_tag_ie1:          IE (tag, build_state_id)
schema.config	1484	
schema.config	1485	
schema.config	1486	build_state_private_tag:        table
schema.config	1487	
schema.config	1488	  build_state_id:               promotion_id M     refers
schema.config	1489	  owner:                        user_id M          refers
schema.config	1490	  tag:                          tag_phrase M
schema.config	1491	
schema.config	1492	  build_state_private_tag_pk:   PK (build_state_id, owner, tag)
schema.config	1493	  build_state_private_tag_ie1:  IE (owner, build_state_id)
schema.config	1494	
schema.config	1495	
schema.config	1496	build_overriden_roots:          table
schema.config	1497	
schema.config	1498	  build_state_id:               promotion_id                refers
schema.config	1499	  original_vcs_root_id:         vcs_root_instance_id M      refers
schema.config	1500	  substitution_vcs_root_id:     vcs_root_instance_id M      refers
schema.config	1501	
schema.config	1502	  build_overriden_roots_pk:     PK (build_state_id, original_vcs_root_id)
schema.config	1503	  build_subst_root_index:       IE (substitution_vcs_root_id)
schema.config	1504	  build_orig_root_index:        IE (original_vcs_root_id)
schema.config	1505	
schema.config	1506	
schema.config	1507	user_roles:                     table
schema.config	1508	
schema.config	1509	  user_id:                      user_id M       refers
schema.config	1510	  role_id:                      user_role_id M  -- we need a dictionary of roles
schema.config	1511	  project_int_id:               project_int_id  refers
schema.config	1512	
schema.config	1513	  user_roles_ui:                AK (user_id, role_id, project_int_id)
schema.config	1514	  user_roles_p_int_id_i:        IE (project_int_id)
schema.config	1515	
schema.config	1516	
schema.config	1517	usergroup_roles:                table
schema.config	1518	
schema.config	1519	  group_id:                     group_id M      refers
schema.config	1520	  role_id:                      user_role_id M  -- we need a dictionary of roles
schema.config	1521	  project_int_id:               project_int_id  refers
schema.config	1522	
schema.config	1523	  usergroup_roles_ui:           AK (group_id, role_id, project_int_id)
schema.config	1524	  usergroup_roles_p_int_id_i:   IE (project_int_id)
schema.config	1525	
schema.config	1526	
schema.config	1528	-- INSPECTIONS AND DUPLICATES
schema.config	1529	
schema.config	1530	inspection_info:                dictionary table
schema.config	1531	
schema.config	1532	  id:                           inspection_id_hash M     defines
schema.config	1533	  inspection_id:                inspection_id_str        defines
schema.config	1534	  inspection_name:              str(255)
schema.config	1535	  inspection_desc:              long_str(4000)
schema.config	1536	  group_name:                   str(255)
schema.config	1537	
schema.config	1538	  inspection_info_pk:           PK (id)                  stable
schema.config	1539	  inspection_info_ak:           AK (inspection_id)       stable
schema.config	1540	
schema.config	1541	
schema.config	1542	inspection_data:                dictionary table
schema.config	1543	
schema.config	1544	  hash:                         inspection_data_hash M   defines
schema.config	1545	  result:                       long_str(4000)
schema.config	1546	  severity:                     int
schema.config	1547	  type_pattern:                 int
schema.config	1548	  fqname:                       long_str(4000)
schema.config	1549	  file_name:                    str(255)
schema.config	1550	  parent_fqnames:               long_str(4000)
schema.config	1551	  parent_type_patterns:         str(20)
schema.config	1552	  module_name:                  str(40)
schema.config	1553	  inspection_id:                inspection_id_hash       refers
schema.config	1554	  is_local:                     int
schema.config	1555	  used:                         int M default 1
schema.config	1556	
schema.config	1557	  inspection_data_pk:           PK (hash)                stable
schema.config	1558	
schema.config	1559	  inspection_data_file_index:   IE (file_name)
schema.config	1560	  inspection_data_insp_index:   IE (inspection_id)
schema.config	1561	
schema.config	1562	
schema.config	1563	inspection_fixes:               table
schema.config	1564	
schema.config	1565	  hash:                         inspection_data_hash M   refers
schema.config	1566	  hint:                         str(255)
schema.config	1567	
schema.config	1568	  inspection_fixes_hash_index:  IE (hash)
schema.config	1569	
schema.config	1570	
schema.config	1571	inspection_results:             table
schema.config	1572	
schema.config	1573	  build_id:                     build_id M               refers
schema.config	1574	  hash:                         inspection_data_hash M   refers
schema.config	1575	  line:                         int M
schema.config	1576	
schema.config	1577	  inspection_results_hash_index:   IE (hash)
schema.config	1578	  inspection_results_buildhash_i:  IE (build_id, hash)
schema.config	1579	
schema.config	1580	
schema.config	1581	inspection_stats:               table
schema.config	1582	
schema.config	1583	  build_id:                     build_id M               refers
schema.config	1584	  total:                        int
schema.config	1585	  new_total:                    int
schema.config	1586	  old_total:                    int
schema.config	1587	  errors:                       int
schema.config	1588	  new_errors:                   int
schema.config	1589	  old_errors:                   int
schema.config	1590	
schema.config	1591	  inspection_stats_pk:          PK (build_id)
schema.config	1592	
schema.config	1593	
schema.config	1594	inspection_diff:                table
schema.config	1595	
schema.config	1596	  build_id:                     build_id M               refers
schema.config	1597	  hash:                         inspection_data_hash M   refers
schema.config	1598	
schema.config	1599	  inspection_diff_ak:           AK (build_id, hash)
schema.config	1600	
schema.config	1601	  inspection_diff_hash_index:   IE (hash)
schema.config	1602	
schema.config	1603	
schema.config	1604	project_files:                  dictionary table
schema.config	1605	
schema.config	1606	  file_id:                      duplicate_file_id M serial defines
schema.config	1607	  file_name:                    duplicate_file_name M
schema.config	1608	
schema.config	1609	  project_files_pk:             PK (file_id)
schema.config	1610	  project_files_ak:             AK (file_name) stable
schema.config	1611	
schema.config	1612	
schema.config	1613	duplicate_results:              table
schema.config	1614	
schema.config	1615	  id:                           duplicate_result_id M serial defines
schema.config	1616	  build_id:                     build_id M refers
schema.config	1617	  hash:                         duplicate_result_hash M defines
schema.config	1618	  cost:                         int
schema.config	1619	
schema.config	1620	  duplicate_results_pk:         PK (id)
schema.config	1621	  duplicate_results_build_i:    IE (build_id)
schema.config	1622	
schema.config	1623	
schema.config	1624	duplicate_diff:                 table
schema.config	1625	
schema.config	1626	  build_id:                     build_id M refers
schema.config	1627	  hash:                         long_int M
schema.config	1628	
schema.config	1629	  duplicate_diff_pk:            PK (build_id, hash)
schema.config	1630	
schema.config	1631	
schema.config	1632	duplicate_fragments:            table
schema.config	1633	
schema.config	1634	  id:                           duplicate_result_id M  refers
schema.config	1635	  file_id:                      duplicate_file_id   M  refers
schema.config	1636	  line:                         int                 M
schema.config	1637	  offset_info:                  str(100)            M
schema.config	1638	
schema.config	1639	  duplicate_fragments_pk:       PK (id, file_id, line, offset_info)
schema.config	1640	  duplicate_fragments_file_i:   IE (file_id)
schema.config	1641	
schema.config	1642	
schema.config	1643	duplicate_stats:                table
schema.config	1644	
schema.config	1645	  build_id:                     build_id M refers
schema.config	1646	  total:                        int
schema.config	1647	  new_total:                    int
schema.config	1648	  old_total:                    int
schema.config	1649	
schema.config	1650	  duplicate_stats_pk:           PK (build_id)
schema.config	1651	
schema.config	1652	
schema.config	1653	
schema.config	1654	
schema.config	1655	-- OTHER TABLES
schema.config	1656	
schema.config	1657	stats_publisher_state:          table
schema.config	1658	
schema.config	1659	  metric_id:                    long_int M
schema.config	1660	  value:                        long_int M
schema.config	1661	
schema.config	1662	  stats_publisher_state_pk:     PK (metric_id)
schema.config	1663	
schema.config	1664	
schema.config	1665	comments:                       table
schema.config	1666	
schema.config	1667	  id:                           audit_comment_id M  serial defines
schema.config	1668	  author_id:                    user_id             refers
schema.config	1669	  when_changed:                 long_int  M
schema.config	1670	  commentary:                   long_uni_str(4096)
schema.config	1671	
schema.config	1672	  comments_pk:                  PK (id)
schema.config	1673	  comments_when_changed_i:      IE (when_changed)
schema.config	1674	
schema.config	1675	
schema.config	1676	action_history:                 table
schema.config	1677	
schema.config	1678	  object_id:                    str(80)
schema.config	1679	  comment_id:                   audit_comment_id    refers
schema.config	1680	  action:                       int
schema.config	1681	  additional_data:              str(80)
schema.config	1682	
schema.config	1683	  action_history_comment:          IE (comment_id)
schema.config	1684	  action_history_object:           IE (object_id)
schema.config	1685	  action_history_action_object_i:  IE (action, object_id)
schema.config	1686	
schema.config	1687	
schema.config	1688	audit_additional_object:        table
schema.config	1689	
schema.config	1690	  comment_id:                   audit_comment_id    refers
schema.config	1691	  object_index:                 int
schema.config	1692	  object_id:                    str(80)
schema.config	1693	  object_name:                  long_uni_str(2500) -- is used only for deleted objects
schema.config	1694	
schema.config	1695	  audit_a_o_comment:            IE (comment_id)
schema.config	1696	
schema.config	1697	
schema.config	1698	build_set_tmp:                  table
schema.config	1699	
schema.config	1700	  build_id:                     build_id M
schema.config	1701	
schema.config	1702	  build_set_pk:                 PK (build_id)
schema.config	1703	
schema.config	1704	
schema.config	1705	clean_checkout_enforcement:     table
schema.config	1706	
schema.config	1707	  build_type_id:                bt_int_id M
schema.config	1708	  agent_id:                     agent_id M
schema.config	1709	  current_build_id:             build_id M
schema.config	1710	  request_time:                 timestamp M
schema.config	1711	
schema.config	1712	  clean_checkout_enforcement_pk: PK (build_type_id, agent_id)
schema.config	1713	
schema.config	1714	server_statistics:              table
schema.config	1715	  metric_key:                   long_int M
schema.config	1716	  metric_value:                 long_int M
schema.config	1717	  metric_timestamp:             long_int M
schema.config	1718	
schema.config	1719	  metric_key_index:             IE (metric_key, metric_timestamp)
schema.config	1720	
schema.config	1721	node_events:                    table
schema.config	1722	  id:                           long_int M serial defines
schema.config	1723	  name:                         str(64)
schema.config	1724	  long_arg1:                    long_int
schema.config	1725	  long_arg2:                    long_int
schema.config	1726	  str_arg:                      str(255)
schema.config	1727	  node_id:                      str(80) M
schema.config	1728	  created:                      timestamp
schema.config	1730	  node_events_pk:               PK (node_id, id)
schema.config	1731	  node_events_created_idx:      IE(created)
schema.config	1732	
schema.config	1733	
schema.config	1734	node_tasks:                     table
schema.config	1735	  id:                           node_task_id M
schema.config	1736	  task_type:                    str(64) M
schema.config	1737	  task_identity:                str(255) M
schema.config	1738	  long_arg1:                    long_int
schema.config	1739	  long_arg2:                    long_int
schema.config	1740	  str_arg:                      uni_str(1024)
schema.config	1741	  long_str_arg_uuid:            str(40)
schema.config	1742	  node_id:                      str(80) M
schema.config	1743	  executor_node_id:             str(80)
schema.config	1744	  task_state:                   int M
schema.config	1745	  result:                       uni_str(1024)
schema.config	1746	  long_result_uuid:             str(40)
schema.config	1747	  created:                      timestamp
schema.config	1748	  finished:                     timestamp
schema.config	1749	  last_activity:                timestamp
schema.config	1750	
schema.config	1751	  node_tasks_pk:                PK (id)
schema.config	1752	  node_tasks_type_ident_ak:     AK (task_type, task_identity, task_state)
schema.config	1753	  node_tasks_task_state_idx:    IE (task_state)
schema.config	1754	
schema.config	1755	
schema.config	1756	node_tasks_long_value:
schema.config	1757	
schema.config	1758	  uuid:                        str(40) M
schema.config	1759	  long_value:                  long_uni_str(65536) M
schema.config	1760	
schema.config	1761	  node_tasks_long_value_pk:    PK(uuid)
schema.config	1762	
schema.config	1763	
schema.config	1764	node_locks:                    table
schema.config	1765	  lock_type:                   str(64) M
schema.config	1766	  lock_arg:                    str(80)
schema.config	1767	  id:                          long_int M
schema.config	1768	  node_id:                     str(80) M
schema.config	1769	  state:                       int M
schema.config	1770	  created:                     long_int M
schema.config	1771	
schema.config	1772	  node_locks_pk:               PK (lock_type, id)
schema.config	1773	  node_locks_node_id_idx:      IE (node_id, id, lock_type)
schema.config	1774	
schema.config	1775	
schema.config	1776	custom_data_body:               table
schema.config	1777	  id:                           custom_data_body_id M serial defines -- id of custom data body
schema.config	1778	  part_num:                     int M              -- body part number (can be > 0 if body length > 2000)
schema.config	1779	  total_parts:                  int M              -- total number of body parts
schema.config	1780	  data_body:                    uni_str(2000)      -- body part
schema.config	1781	  update_date:                  long_int M         -- timestamp when this part was created or updated
schema.config	1782	
schema.config	1783	  custom_data_body_idx:         AK (id, part_num)
schema.config	1784	  custom_data_body_ud_idx:      IE (update_date)
schema.config	1785	
schema.config	1786	custom_data:                    table
schema.config	1787	  data_key_hash:                str(80) M          -- sha1 of concat(data_domain, data_key), we need it because MySQL can't create index for column > 760 chars
schema.config	1788	  collision_idx:                int M              -- used only if we detected sha1 collision
schema.config	1789	  data_domain:                  str(80) M          -- custom data domain: buildType:<id>, project:<id> or vcsRoot:<id>
schema.config	1790	  data_key:                     uni_str(2000) M    -- custom data storage id
schema.config	1791	  data_id:                      custom_data_body_id M  refers   -- id of custom data body
schema.config	1792	
schema.config	1793	  custom_data_key_hash_idx:     AK (data_key_hash, collision_idx)
schema.config	1794	  custom_data_domain_idx:       IE (data_domain)
schema.config	1795	  custom_data_body_id_idx:      IE (data_id)
schema.config	1796	
schema.config	1797	
schema.config	1798	-- SERVER HEALTH TABLES --
schema.config	1799	
schema.config	1800	server_health_items:            table
schema.config	1801	
schema.config	1802	  id:                           server_health_item_id M serial defines
schema.config	1803	  report_id:                    str(80) M
schema.config	1804	  category_id:                  str(80) M
schema.config	1805	  item_id:                      str(255) M
schema.config	1806	
schema.config	1807	  server_health_items_pk:       PK (id)
schema.config	1808	  server_health_items_ie:       IE (report_id, category_id)
schema.config	1809	
schema.config	1810	hidden_health_item:             table
schema.config	1811	
schema.config	1812	  item_id:                      server_health_item_id M    refers
schema.config	1813	  user_id:                      user_id                    refers    -- null if item is invisible for everyone
schema.config	1814	  health_item_id_ie:            IE (item_id)
schema.config	1815	
schema.config	1816	
schema.config	1817	config_persisting_tasks:       table
schema.config	1818	
schema.config	1819	  id:                          long_int M        -- task id, unique within a specific type
schema.config	1820	  task_type:                   str(20) M         -- the type of the tasks
schema.config	1821	  description:                 uni_str(2000)     -- some human friendly description of the task
schema.config	1822	  stage:                       int M
schema.config	1823	  node_id:                     str(80) M         -- id of a node which created this task
schema.config	1824	  created:                     long_int M        -- timestamp when the task was created
schema.config	1825	  updated:                     long_int M default 0      -- timestamp when the task was updated
schema.config	1826	
schema.config	1827	  config_persisting_tasks_pk:  PK (id, task_type)
schema.config	1828	  config_persisting_tasks_ie:  IE (task_type, stage)
schema.config	1829	
schema.config	1830	
schema.config	1831	
schema.config	1832	-- DEPRECATED TABLES (will not be populated anymore)
schema.config	1833	
schema.config	1834	
schema.config	1835	vcs_changes:                    deprecated table
schema.config	1836	
schema.config	1837	  modification_id:              modification_id
schema.config	1838	  change_name:                  str(64)
schema.config	1839	  change_type:                  int
schema.config	1840	  before_revision:              long_str(2048)
schema.config	1841	  after_revision:               long_str(2048)
schema.config	1842	  vcs_file_name:                long_str(16000)
schema.config	1843	  relative_file_name:           long_str(16000)
schema.config	1844	
schema.config	1845	  vcs_changes_index:            IE (modification_id)
schema.config	1846	
schema.config	1847	
schema.config	1848	personal_vcs_changes:           deprecated table
schema.config	1849	
schema.config	1850	  modification_id:              modification_id
schema.config	1851	  change_name:                  str(64)
schema.config	1852	  change_type:                  int
schema.config	1853	  before_revision:              str(2048)
schema.config	1854	  after_revision:               str(2048)
schema.config	1855	  vcs_file_name:                long_str(16000)
schema.config	1856	  relative_file_name:           long_str(16000)
schema.config	1857	
schema.config	1858	  vcs_personal_changes_index:   IE (modification_id)
schema.config	1859	
schema.config	1860	
schema.config	1861	light_history:                  deprecated table
schema.config	1862	
schema.config	1863	  build_id:                     build_id M
schema.config	1864	  agent_name:                   str(80)
schema.config	1865	  build_type_id:                bt_int_id    refers
schema.config	1866	  build_start_time_server:      long_int
schema.config	1867	  build_start_time_agent:       long_int
schema.config	1868	  build_finish_time_server:     long_int
schema.config	1869	  status:                       int
schema.config	1870	  status_text:                  uni_str(256)
schema.config	1871	  user_status_text:             uni_str(256)
schema.config	1872	  pin:                          int
schema.config	1873	  is_personal:                  int
schema.config	1874	  is_canceled:                  int
schema.config	1875	  build_number:                 str(256)
schema.config	1876	  requestor:                    str(1024)
schema.config	1877	  queued_time:                  long_int
schema.config	1878	  remove_from_queue_time:       long_int
schema.config	1879	  build_state_id:               long_int
schema.config	1880	  agent_type_id:                agent_type_id
schema.config	1881	  branch_name:                  str(255)
schema.config	1882	
schema.config	1883	  light_history_pk:              PK (build_id)
schema.config	1884	
schema.config	1885	  start_time_index_light:        IE (build_start_time_server)
schema.config	1886	  light_history_finish_time_i:   IE (build_finish_time_server)
schema.config	1887	  stats_optimized_index:         IE (build_type_id, status, is_canceled, branch_name)
schema.config	1888	  light_history_agt_b_i:         IE (agent_type_id, build_id)
schema.config	1889	
schema.config	1890	
schema.config	1891	-- TEMPORARY TABLES
schema.config	1892	
schema.config	1893	
schema.config	1894	agent_pool$:                    temporary table
schema.config	1895	
schema.config	1896	  agent_pool_id:                agent_pool_id M
schema.config	1897	
schema.config	1898	
schema.config	1899	agent_type$:                    temporary table
schema.config	1900	
schema.config	1901	  agent_type_id:                agent_type_id M
schema.config	1902	
schema.config	1903	
schema.config	1904	project$:                       temporary table
schema.config	1905	
schema.config	1906	  int_id:                       project_int_id M
schema.config	1907	
schema.config	1908	
schema.config	1909	build_type$:                    temporary table
schema.config	1910	
schema.config	1911	  build_type_id:                bt_int_id M
schema.config	1912	
schema.config	1913	
schema.config	1914	vcs_root_instance$:            temporary table
schema.config	1915	
schema.config	1916	  id:                           vcs_root_instance_id M
schema.config	1917	
schema.config	1918	
schema.config	1919	modification$:                  temporary table
schema.config	1920	
schema.config	1921	  modification_id:              modification_id M
schema.config	1922	
schema.config	1923	
schema.config	1924	promotion$:                     temporary table
schema.config	1925	
schema.config	1926	  id:                           promotion_id M   -- build_state_id in other tables
schema.config	1927	
schema.config	1928	
schema.config	1929	build$:                         temporary table
schema.config	1930	
schema.config	1931	  build_id:                     build_id M
schema.config	1932	
schema.config	1933	
schema.config	1934	test$:                          temporary table
schema.config	1935	
schema.config	1936	  test_name_id:                 test_name_hash M
schema.config	1937	
schema.config	1938	
schema.config	1939	test_key$:                      temporary table
schema.config	1940	
schema.config	1941	  test_name_id:                 test_name_hash M
schema.config	1942	  test_key_pk:                  PK (test_name_id)
schema.config	1943	
schema.config	1944	
schema.config	1945	problem$:                       temporary table
schema.config	1946	
schema.config	1947	  problem_id:                   problem_id M
schema.config	1948	
schema.config	1949	
schema.config	1950	branch$:                        temporary table
schema.config	1951	
schema.config	1952	  branch_name:                  uni_str(1024) M
schema.config	1953	
schema.config	1954	
schema.config	1955	audit_object_ids_to_cleanup$:   temporary table
schema.config	1956	
schema.config	1957	  object_id:                    str(80) M
schema.config	1958	
schema.config	1959	
schema.config	1960	audit_comment_ids_to_cleanup$:  temporary table
schema.config	1961	
schema.config	1962	  comment_id:                   audit_comment_id M
schema.config	1963	
schema.config	1964	
schema.config	1965	user$:                          temporary table
schema.config	1966	
schema.config	1967	  user_id:                      user_id M
schema.config	1968	
schema.config	1969	
schema.config	1970	custom_data_body_id$:           temporary table
schema.config	1971	
schema.config	1972	  id:                           long_int M
schema.config	1973	
schema.config	1974	custom_data_domain$:            temporary table
schema.config	1975	
schema.config	1976	  data_domain:                  str(80) M
schema.config	1977	
schema.config	1978	duplicate_file_name$:             temporary table
schema.config	1979	
schema.config	1980	  file_name:                    duplicate_file_name M
schema.config	1981	
schema.config	1982	ids_group$:                     temporary table
schema.config	1983	
schema.config	1984	  group_id:                     ids_group_id M
schema.config	1985	
schema.config	1986	
schema.config	1987	
schema.config	1988	-- THE LAST TABLE
schema.config	1989	
schema.config	1990	server:                         table
schema.config	1991	
schema.config	1992	  server_id:                    long_int
\.


--
-- Data for Name: mute_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_info (mute_id, muting_user_id, muting_time, muting_comment, scope, project_int_id, build_id, unmute_when_fixed, unmute_by_time) FROM stdin;
\.


--
-- Data for Name: mute_info_bt; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_info_bt (mute_id, build_type_id) FROM stdin;
\.


--
-- Data for Name: mute_info_problem; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_info_problem (mute_id, problem_id) FROM stdin;
\.


--
-- Data for Name: mute_info_test; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_info_test (mute_id, test_name_id) FROM stdin;
\.


--
-- Data for Name: mute_problem_in_bt; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_problem_in_bt (mute_id, build_type_id, problem_id) FROM stdin;
\.


--
-- Data for Name: mute_problem_in_proj; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_problem_in_proj (mute_id, project_int_id, problem_id) FROM stdin;
\.


--
-- Data for Name: mute_test_in_bt; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_test_in_bt (mute_id, build_type_id, test_name_id) FROM stdin;
\.


--
-- Data for Name: mute_test_in_proj; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.mute_test_in_proj (mute_id, project_int_id, test_name_id) FROM stdin;
\.


--
-- Data for Name: node_events; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.node_events (id, name, long_arg1, long_arg2, str_arg, node_id, created) FROM stdin;
\.


--
-- Data for Name: node_locks; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.node_locks (lock_type, lock_arg, id, node_id, state, created) FROM stdin;
\.


--
-- Data for Name: node_tasks; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.node_tasks (id, task_type, task_identity, long_arg1, long_arg2, str_arg, long_str_arg_uuid, node_id, executor_node_id, task_state, result, long_result_uuid, created, finished, last_activity) FROM stdin;
11	processingTriggers	processingTriggers-remoteRunOnBranch	\N	\N	remoteRunOnBranch	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.721073	\N	\N
12	processingTriggers	processingTriggers-vcsTrigger	\N	\N	vcsTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.72666	\N	\N
13	processingTriggers	processingTriggers-schedulingTrigger	\N	\N	schedulingTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.731698	\N	\N
14	processingTriggers	processingTriggers-mavenArtifactDependencyTrigger	\N	\N	mavenArtifactDependencyTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.739774	\N	\N
15	processingTriggers	processingTriggers-retryBuildTrigger	\N	\N	retryBuildTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.748506	\N	\N
16	processingTriggers	processingTriggers-nuget.simple	\N	\N	nuget.simple	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.755316	\N	\N
17	processingTriggers	processingTriggers-perforceShelveTrigger	\N	\N	perforceShelveTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.762664	\N	\N
18	processingTriggers	processingTriggers-buildDependencyTrigger	\N	\N	buildDependencyTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.769627	\N	\N
19	processingTriggers	processingTriggers-GitHubChecksTrigger	\N	\N	GitHubChecksTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.776091	\N	\N
20	processingTriggers	processingTriggers-mavenSnapshotDependencyTrigger	\N	\N	mavenSnapshotDependencyTrigger	\N	server-0	\N	0	\N	\N	2025-07-20 10:02:55.784522	\N	\N
421	agentCommand:upgrade	agentId:1	\N	\N	{"body":"","contentType":"text/plain"}	\N	server-0	\N	60026788	SUCCESS:true	\N	2025-07-20 10:09:47.347693	2025-07-20 10:09:47.535	2025-07-20 10:09:47.535
542	agentCommand:upgrade	agentId:1	\N	\N	{"body":"","contentType":"text/plain"}	\N	server-0	\N	53904488	SUCCESS:true	\N	2025-07-20 10:11:44.127469	2025-07-20 10:11:44.155	2025-07-20 10:11:44.155
1	processingTriggers	processingTriggers-remoteRunOnBranch	\N	\N	remoteRunOnBranch	\N	server-0	server-0	66951544	\N	\N	2025-07-20 10:02:43.998786	2025-07-20 10:24:27.327	2025-07-20 10:24:27.327
2	processingTriggers	processingTriggers-vcsTrigger	\N	\N	vcsTrigger	\N	server-0	server-0	63764056	\N	\N	2025-07-20 10:02:44.009288	2025-07-20 10:24:27.329	2025-07-20 10:24:27.329
3	processingTriggers	processingTriggers-schedulingTrigger	\N	\N	schedulingTrigger	\N	server-0	server-0	60754312	\N	\N	2025-07-20 10:02:44.02134	2025-07-20 10:24:27.332	2025-07-20 10:24:27.332
4	processingTriggers	processingTriggers-mavenArtifactDependencyTrigger	\N	\N	mavenArtifactDependencyTrigger	\N	server-0	server-0	56650168	\N	\N	2025-07-20 10:02:44.030123	2025-07-20 10:24:27.334	2025-07-20 10:24:27.334
5	processingTriggers	processingTriggers-retryBuildTrigger	\N	\N	retryBuildTrigger	\N	server-0	server-0	56291355	\N	\N	2025-07-20 10:02:44.0398	2025-07-20 10:24:27.336	2025-07-20 10:24:27.336
6	processingTriggers	processingTriggers-nuget.simple	\N	\N	nuget.simple	\N	server-0	server-0	59932059	\N	\N	2025-07-20 10:02:44.046569	2025-07-20 10:24:27.339	2025-07-20 10:24:27.339
7	processingTriggers	processingTriggers-perforceShelveTrigger	\N	\N	perforceShelveTrigger	\N	server-0	server-0	57020877	\N	\N	2025-07-20 10:02:44.058071	2025-07-20 10:24:27.34	2025-07-20 10:24:27.34
8	processingTriggers	processingTriggers-buildDependencyTrigger	\N	\N	buildDependencyTrigger	\N	server-0	server-0	56244546	\N	\N	2025-07-20 10:02:44.082412	2025-07-20 10:24:27.343	2025-07-20 10:24:27.343
9	processingTriggers	processingTriggers-GitHubChecksTrigger	\N	\N	GitHubChecksTrigger	\N	server-0	server-0	65687522	\N	\N	2025-07-20 10:02:44.088868	2025-07-20 10:24:27.345	2025-07-20 10:24:27.345
10	processingTriggers	processingTriggers-mavenSnapshotDependencyTrigger	\N	\N	mavenSnapshotDependencyTrigger	\N	server-0	server-0	51476864	\N	\N	2025-07-20 10:02:44.094268	2025-07-20 10:24:27.347	2025-07-20 10:24:27.347
\.


--
-- Data for Name: node_tasks_long_value; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.node_tasks_long_value (uuid, long_value) FROM stdin;
\.


--
-- Data for Name: permanent_token_permissions; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.permanent_token_permissions (id, project_id, permission) FROM stdin;
\.


--
-- Data for Name: permanent_tokens; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.permanent_tokens (id, identifier, name, user_id, hashed_value, expiration_time, creation_time, last_access_time, last_access_info, type) FROM stdin;
\.


--
-- Data for Name: personal_build_relative_path; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.personal_build_relative_path (build_id, original_path_hash, relative_path) FROM stdin;
\.


--
-- Data for Name: personal_vcs_change; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.personal_vcs_change (modification_id, file_num, vcs_file_name, vcs_file_name_hash, relative_file_name_pos, relative_file_name, relative_file_name_hash, change_type, change_name, before_revision, after_revision) FROM stdin;
\.


--
-- Data for Name: personal_vcs_changes; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.personal_vcs_changes (modification_id, change_name, change_type, before_revision, after_revision, vcs_file_name, relative_file_name) FROM stdin;
\.


--
-- Data for Name: personal_vcs_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.personal_vcs_history (modification_id, modification_hash, user_id, description, change_date, changes_count, commit_changes, status, scheduled_for_deletion) FROM stdin;
\.


--
-- Data for Name: problem; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.problem (problem_id, problem_type, problem_identity) FROM stdin;
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.project (int_id, config_id, origin_project_id, delete_time) FROM stdin;
_Root	4f99f255-fab3-427d-8668-1a63d08ea5b7	\N	\N
\.


--
-- Data for Name: project_files; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.project_files (file_id, file_name) FROM stdin;
\.


--
-- Data for Name: project_mapping; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.project_mapping (int_id, ext_id, main) FROM stdin;
_Root	_Root	1
\.


--
-- Data for Name: remember_me; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.remember_me (user_key, secure) FROM stdin;
\.


--
-- Data for Name: removed_builds_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.removed_builds_history (build_id, agent_name, build_type_id, build_start_time_server, build_start_time_agent, build_finish_time_server, status, status_text, user_status_text, pin, is_personal, is_canceled, build_number, requestor, queued_time, remove_from_queue_time, build_state_id, agent_type_id, branch_name) FROM stdin;
\.


--
-- Data for Name: repository_state; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.repository_state (vcs_root_id, node_id, update_time) FROM stdin;
\.


--
-- Data for Name: repository_state_branches; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.repository_state_branches (vcs_root_id, branch_id, revision, creation_time) FROM stdin;
\.


--
-- Data for Name: responsibilities; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.responsibilities (problem_id, state, responsible_user_id, reporter_user_id, timestmp, remove_method, comments) FROM stdin;
\.


--
-- Data for Name: running; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.running (build_id, agent_id, build_type_id, build_start_time_agent, build_start_time_server, build_finish_time_server, last_build_activity_time, is_personal, build_number, build_counter, requestor, access_code, queued_ag_restr_type_id, queued_ag_restr_id, build_state_id, agent_type_id, user_status_text, progress_text, current_path_text) FROM stdin;
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.server (server_id) FROM stdin;
1753005700958
\.


--
-- Data for Name: server_health_items; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.server_health_items (id, report_id, category_id, item_id) FROM stdin;
\.


--
-- Data for Name: server_property; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.server_property (prop_name, prop_value) FROM stdin;
***	8f80140d1868578ad3b346d06d25f6c10000
LICENSE_AGREEMENT	true
\.


--
-- Data for Name: server_statistics; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.server_statistics (metric_key, metric_value, metric_timestamp) FROM stdin;
1	0	1753005824171
3	3	1753005824171
2	0	1753005824171
\.


--
-- Data for Name: single_row; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.single_row (dummy_field) FROM stdin;
X
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.stats (build_id, test_count) FROM stdin;
\.


--
-- Data for Name: stats_publisher_state; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.stats_publisher_state (metric_id, value) FROM stdin;
-5264660594081243009	0
-4539345364261023841	0
8170543957031342021	0
6662056484837638591	0
-3896958621569208557	0
9018439616396414058	0
-1749670243861784615	0
-6826520637656720981	0
-6371738409877395985	0
6422310138526701845	0
-959614572394077983	0
3014510524022395756	0
5744866293795496522	0
-6912521911911837242	0
-6022911269954286022	0
8605895206854366408	0
476730929325259819	0
4232402363381785151	0
\.


--
-- Data for Name: test_failure_rate; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_failure_rate (build_type_id, test_name_id, success_count, failure_count, last_failure_time) FROM stdin;
\.


--
-- Data for Name: test_info; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_info (build_id, test_id, test_name_id, status, duration) FROM stdin;
\.


--
-- Data for Name: test_info_archive; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_info_archive (build_id, test_id, test_name_id, status, duration) FROM stdin;
\.


--
-- Data for Name: test_metadata; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_metadata (build_id, test_id, test_name_id, key_id, type_id, str_value, num_value) FROM stdin;
\.


--
-- Data for Name: test_metadata_dict; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_metadata_dict (key_id, name_digest, name) FROM stdin;
\.


--
-- Data for Name: test_metadata_types; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_metadata_types (type_id, name) FROM stdin;
\.


--
-- Data for Name: test_muted; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_muted (build_id, test_name_id, mute_id) FROM stdin;
\.


--
-- Data for Name: test_names; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.test_names (id, test_name, order_num) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_attribute (user_id, attr_key, attr_value, locase_value_hash) FROM stdin;
\.


--
-- Data for Name: user_blocks; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_blocks (user_id, block_type, state) FROM stdin;
\.


--
-- Data for Name: user_build_parameters; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_build_parameters (build_state_id, param_name, param_value) FROM stdin;
\.


--
-- Data for Name: user_build_types_order; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_build_types_order (user_id, project_int_id, bt_int_id, ordernum, visible) FROM stdin;
\.


--
-- Data for Name: user_notification_data; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_notification_data (user_id, rule_id, additional_data) FROM stdin;
\.


--
-- Data for Name: user_notification_events; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_notification_events (id, user_id, notificator_type, events_mask) FROM stdin;
\.


--
-- Data for Name: user_projects_order; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_projects_order (user_id, project_int_id, ordernum) FROM stdin;
\.


--
-- Data for Name: user_projects_visibility; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_projects_visibility (user_id, project_int_id, visible) FROM stdin;
\.


--
-- Data for Name: user_property; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_property (user_id, prop_key, prop_value, locase_value_hash) FROM stdin;
1	teamcity.server.buildNumber	186370	1456205053
1	addTriggeredBuildToFavorites	true	3569038
1	was.logged.in	true	3569038
1	lastSeenSakuraUIVersion	2025.03.3	563958741
1	hasSeenExperimentalOverview	true	3569038
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_roles (user_id, role_id, project_int_id) FROM stdin;
-1000	PROJECT_VIEWER	\N
1	SYSTEM_ADMIN	\N
\.


--
-- Data for Name: user_watch_type; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.user_watch_type (rule_id, user_id, notificator_type, watch_type, watch_value, order_num) FROM stdin;
\.


--
-- Data for Name: usergroup_notification_data; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_notification_data (group_id, rule_id, additional_data) FROM stdin;
ALL_USERS_GROUP	1	userChangesOnly='true'
ALL_USERS_GROUP	2	userChangesOnly='true'
\.


--
-- Data for Name: usergroup_notification_events; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_notification_events (id, group_id, notificator_type, events_mask) FROM stdin;
1	ALL_USERS_GROUP	email	8260
2	ALL_USERS_GROUP	IDE_Notificator	76
3	ALL_USERS_GROUP	email	512
4	ALL_USERS_GROUP	IDE_Notificator	512
5	ALL_USERS_GROUP	WindowsTray	512
6	ALL_USERS_GROUP	jabber	512
\.


--
-- Data for Name: usergroup_property; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_property (group_id, prop_key, prop_value) FROM stdin;
\.


--
-- Data for Name: usergroup_roles; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_roles (group_id, role_id, project_int_id) FROM stdin;
ALL_USERS_GROUP	PROJECT_DEVELOPER	\N
\.


--
-- Data for Name: usergroup_subgroups; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_subgroups (hostgroup_id, subgroup_id) FROM stdin;
\.


--
-- Data for Name: usergroup_users; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_users (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: usergroup_watch_type; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroup_watch_type (rule_id, group_id, notificator_type, watch_type, watch_value, order_num) FROM stdin;
1	ALL_USERS_GROUP	email	2	_Root	1
2	ALL_USERS_GROUP	IDE_Notificator	2	_Root	1
3	ALL_USERS_GROUP	email	5	__SYSTEM_WIDE__	2
4	ALL_USERS_GROUP	IDE_Notificator	5	__SYSTEM_WIDE__	2
5	ALL_USERS_GROUP	WindowsTray	5	__SYSTEM_WIDE__	1
6	ALL_USERS_GROUP	jabber	5	__SYSTEM_WIDE__	1
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.usergroups (group_id, name, description) FROM stdin;
ALL_USERS_GROUP	All Users	Contains all TeamCity users
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.users (id, username, password, name, email, last_login_timestamp, algorithm) FROM stdin;
1	__admin_username__	__admin_password__			1753005816503	BCRYPT
\.


--
-- Data for Name: vcs_change; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_change (modification_id, file_num, vcs_file_name, vcs_file_name_hash, relative_file_name_pos, relative_file_name, relative_file_name_hash, change_type, change_name, before_revision, after_revision) FROM stdin;
\.


--
-- Data for Name: vcs_change_attrs; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_change_attrs (modification_id, attr_name, attr_value) FROM stdin;
\.


--
-- Data for Name: vcs_changes; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_changes (modification_id, change_name, change_type, before_revision, after_revision, vcs_file_name, relative_file_name) FROM stdin;
\.


--
-- Data for Name: vcs_changes_graph; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_changes_graph (child_modification_id, child_revision, parent_num, parent_modification_id, parent_revision) FROM stdin;
\.


--
-- Data for Name: vcs_history; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_history (modification_id, user_name, description, change_date, register_date, vcs_root_id, changes_count, version, display_version) FROM stdin;
\.


--
-- Data for Name: vcs_root; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_root (int_id, config_id, origin_project_id, delete_time) FROM stdin;
-1	00000000-0000-4000-8000-000000000000	\N	\N
\.


--
-- Data for Name: vcs_root_first_revision; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_root_first_revision (build_type_id, parent_root_id, settings_hash, vcs_revision) FROM stdin;
\.


--
-- Data for Name: vcs_root_instance; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_root_instance (id, parent_id, settings_hash, body) FROM stdin;
\.


--
-- Data for Name: vcs_root_mapping; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_root_mapping (int_id, ext_id, main) FROM stdin;
-1	_deleted_vcs_root	1
\.


--
-- Data for Name: vcs_username; Type: TABLE DATA; Schema: public; Owner: teamcity
--

COPY public.vcs_username (user_id, vcs_name, parent_vcs_root_id, order_num, username) FROM stdin;
1	anyVcs	-1	0	admin
\.


--
-- Name: agent agent_name_ui; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_name_ui UNIQUE (name);


--
-- Name: agent agent_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_pk PRIMARY KEY (id);


--
-- Name: agent_pool agent_pool_id_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_pool
    ADD CONSTRAINT agent_pool_id_pk PRIMARY KEY (agent_pool_id);


--
-- Name: agent_pool_project agent_pool_project_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_pool_project
    ADD CONSTRAINT agent_pool_project_pk PRIMARY KEY (agent_pool_id, project_int_id);


--
-- Name: agent_type agent_type_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type
    ADD CONSTRAINT agent_type_ak UNIQUE (cloud_code, profile_id, image_id);


--
-- Name: agent_type_bt_access agent_type_bt_access_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type_bt_access
    ADD CONSTRAINT agent_type_bt_access_pk PRIMARY KEY (agent_type_id, build_type_id);


--
-- Name: agent_type_info agent_type_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type_info
    ADD CONSTRAINT agent_type_info_pk PRIMARY KEY (agent_type_id);


--
-- Name: agent_type_param agent_type_param_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type_param
    ADD CONSTRAINT agent_type_param_pk PRIMARY KEY (agent_type_id, param_kind, param_name);


--
-- Name: agent_type agent_type_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type
    ADD CONSTRAINT agent_type_pk PRIMARY KEY (agent_type_id);


--
-- Name: agent_type_runner agent_type_runner_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type_runner
    ADD CONSTRAINT agent_type_runner_pk PRIMARY KEY (agent_type_id, runner);


--
-- Name: agent_type_vcs agent_type_vcs_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.agent_type_vcs
    ADD CONSTRAINT agent_type_vcs_pk PRIMARY KEY (agent_type_id, vcs);


--
-- Name: backup_builds backup_builds_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.backup_builds
    ADD CONSTRAINT backup_builds_pk PRIMARY KEY (build_id);


--
-- Name: backup_info backup_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.backup_info
    ADD CONSTRAINT backup_info_pk PRIMARY KEY (mproc_id);


--
-- Name: branch_name_dict branch_name_idx; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.branch_name_dict
    ADD CONSTRAINT branch_name_idx UNIQUE (branch_name_hash, insertion_time);


--
-- Name: branch_name_dict branch_name_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.branch_name_dict
    ADD CONSTRAINT branch_name_pk PRIMARY KEY (id);


--
-- Name: build_attrs build_attrs_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_attrs
    ADD CONSTRAINT build_attrs_pk PRIMARY KEY (build_state_id, attr_name);


--
-- Name: build_checkout_rules build_checkout_rules_vid_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_checkout_rules
    ADD CONSTRAINT build_checkout_rules_vid_pk PRIMARY KEY (build_state_id, vcs_root_id);


--
-- Name: build_data_storage build_data_storage_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_data_storage
    ADD CONSTRAINT build_data_storage_pk PRIMARY KEY (build_id, metric_id);


--
-- Name: build_dependency build_dependency_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_dependency
    ADD CONSTRAINT build_dependency_pk PRIMARY KEY (build_state_id, depends_on);


--
-- Name: build_labels build_labels_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_labels
    ADD CONSTRAINT build_labels_pk PRIMARY KEY (build_id, vcs_root_id);


--
-- Name: build_overriden_roots build_overriden_roots_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_overriden_roots
    ADD CONSTRAINT build_overriden_roots_pk PRIMARY KEY (build_state_id, original_vcs_root_id);


--
-- Name: build_problem_attribute build_problem_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_problem_attribute
    ADD CONSTRAINT build_problem_attribute_pk PRIMARY KEY (build_state_id, problem_id, attr_name);


--
-- Name: build_problem_muted build_problem_muted_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_problem_muted
    ADD CONSTRAINT build_problem_muted_pk PRIMARY KEY (build_state_id, problem_id);


--
-- Name: build_problem build_problem_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_problem
    ADD CONSTRAINT build_problem_pk PRIMARY KEY (build_state_id, problem_id);


--
-- Name: build_project build_project_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_project
    ADD CONSTRAINT build_project_pk PRIMARY KEY (build_id, project_level);


--
-- Name: build_queue_order build_queue_order_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_queue_order
    ADD CONSTRAINT build_queue_order_pk PRIMARY KEY (version, line_num);


--
-- Name: build_revisions build_revisions_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_revisions
    ADD CONSTRAINT build_revisions_pk PRIMARY KEY (build_state_id, vcs_root_id);


--
-- Name: build_set_tmp build_set_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_set_tmp
    ADD CONSTRAINT build_set_pk PRIMARY KEY (build_id);


--
-- Name: build_state build_state_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_state
    ADD CONSTRAINT build_state_pk PRIMARY KEY (id);


--
-- Name: build_state_private_tag build_state_private_tag_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_state_private_tag
    ADD CONSTRAINT build_state_private_tag_pk PRIMARY KEY (build_state_id, owner, tag);


--
-- Name: build_state_tag build_state_tag_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_state_tag
    ADD CONSTRAINT build_state_tag_pk PRIMARY KEY (build_state_id, tag);


--
-- Name: build_type build_type_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type
    ADD CONSTRAINT build_type_ak UNIQUE (config_id);


--
-- Name: build_type_counters build_type_counters_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type_counters
    ADD CONSTRAINT build_type_counters_pk PRIMARY KEY (build_type_id);


--
-- Name: build_type_edge_relation build_type_edge_relation_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type_edge_relation
    ADD CONSTRAINT build_type_edge_relation_pk PRIMARY KEY (child_modification_id, build_type_id, parent_num);


--
-- Name: build_type_mapping build_type_mapping_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type_mapping
    ADD CONSTRAINT build_type_mapping_ak UNIQUE (ext_id);


--
-- Name: build_type_mapping build_type_mapping_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type_mapping
    ADD CONSTRAINT build_type_mapping_pk PRIMARY KEY (int_id, ext_id);


--
-- Name: build_type build_type_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type
    ADD CONSTRAINT build_type_pk PRIMARY KEY (int_id);


--
-- Name: build_type_vcs_change build_type_vcs_change_ui; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.build_type_vcs_change
    ADD CONSTRAINT build_type_vcs_change_ui UNIQUE (modification_id, build_type_id);


--
-- Name: canceled_info canceled_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.canceled_info
    ADD CONSTRAINT canceled_info_pk PRIMARY KEY (build_id);


--
-- Name: clean_checkout_enforcement clean_checkout_enforcement_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.clean_checkout_enforcement
    ADD CONSTRAINT clean_checkout_enforcement_pk PRIMARY KEY (build_type_id, agent_id);


--
-- Name: cleanup_history cleanup_history_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cleanup_history
    ADD CONSTRAINT cleanup_history_pk PRIMARY KEY (proc_id);


--
-- Name: cloud_image_state cloud_image_state_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cloud_image_state
    ADD CONSTRAINT cloud_image_state_pk PRIMARY KEY (project_id, profile_id, image_id);


--
-- Name: cloud_image_without_agent cloud_image_without_agent_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cloud_image_without_agent
    ADD CONSTRAINT cloud_image_without_agent_pk PRIMARY KEY (profile_id, cloud_code, image_id);


--
-- Name: cloud_instance_state cloud_instance_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cloud_instance_state
    ADD CONSTRAINT cloud_instance_pk PRIMARY KEY (project_id, profile_id, image_id, instance_id);


--
-- Name: cloud_started_instance cloud_started_instance_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cloud_started_instance
    ADD CONSTRAINT cloud_started_instance_pk PRIMARY KEY (profile_id, cloud_code, image_id, instance_id);


--
-- Name: cloud_state_data cloud_state_data_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.cloud_state_data
    ADD CONSTRAINT cloud_state_data_pk PRIMARY KEY (project_id, profile_id, image_id, instance_id);


--
-- Name: comments comments_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pk PRIMARY KEY (id);


--
-- Name: config_persisting_tasks config_persisting_tasks_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.config_persisting_tasks
    ADD CONSTRAINT config_persisting_tasks_pk PRIMARY KEY (id, task_type);


--
-- Name: custom_data_body custom_data_body_idx; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.custom_data_body
    ADD CONSTRAINT custom_data_body_idx UNIQUE (id, part_num);


--
-- Name: custom_data custom_data_key_hash_idx; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.custom_data
    ADD CONSTRAINT custom_data_key_hash_idx UNIQUE (data_key_hash, collision_idx);


--
-- Name: db_heartbeat db_heartbeat_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.db_heartbeat
    ADD CONSTRAINT db_heartbeat_pk PRIMARY KEY (starting_code);


--
-- Name: db_version db_version_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.db_version
    ADD CONSTRAINT db_version_pk PRIMARY KEY (version_number);


--
-- Name: domain_sequence domain_name_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.domain_sequence
    ADD CONSTRAINT domain_name_pk PRIMARY KEY (domain_name);


--
-- Name: duplicate_diff duplicate_diff_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.duplicate_diff
    ADD CONSTRAINT duplicate_diff_pk PRIMARY KEY (build_id, hash);


--
-- Name: duplicate_fragments duplicate_fragments_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.duplicate_fragments
    ADD CONSTRAINT duplicate_fragments_pk PRIMARY KEY (id, file_id, line, offset_info);


--
-- Name: duplicate_vcs_modification duplicate_mods_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.duplicate_vcs_modification
    ADD CONSTRAINT duplicate_mods_pk PRIMARY KEY (modification_id);


--
-- Name: duplicate_results duplicate_results_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.duplicate_results
    ADD CONSTRAINT duplicate_results_pk PRIMARY KEY (id);


--
-- Name: duplicate_stats duplicate_stats_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.duplicate_stats
    ADD CONSTRAINT duplicate_stats_pk PRIMARY KEY (build_id);


--
-- Name: failed_tests_output failed_tests_output_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.failed_tests_output
    ADD CONSTRAINT failed_tests_output_pk PRIMARY KEY (build_id, test_id);


--
-- Name: failed_tests failed_tests_pk2; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.failed_tests
    ADD CONSTRAINT failed_tests_pk2 PRIMARY KEY (test_name_id, build_id);


--
-- Name: usergroup_notification_data group_notif_data_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_notification_data
    ADD CONSTRAINT group_notif_data_pk PRIMARY KEY (group_id, rule_id);


--
-- Name: history history_build_id_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_build_id_pk PRIMARY KEY (build_id);


--
-- Name: ids_group ids_group_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.ids_group
    ADD CONSTRAINT ids_group_pk PRIMARY KEY (id);


--
-- Name: inspection_data inspection_data_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.inspection_data
    ADD CONSTRAINT inspection_data_pk PRIMARY KEY (hash);


--
-- Name: inspection_diff inspection_diff_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.inspection_diff
    ADD CONSTRAINT inspection_diff_ak UNIQUE (build_id, hash);


--
-- Name: inspection_info inspection_info_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.inspection_info
    ADD CONSTRAINT inspection_info_ak UNIQUE (inspection_id);


--
-- Name: inspection_info inspection_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.inspection_info
    ADD CONSTRAINT inspection_info_pk PRIMARY KEY (id);


--
-- Name: inspection_stats inspection_stats_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.inspection_stats
    ADD CONSTRAINT inspection_stats_pk PRIMARY KEY (build_id);


--
-- Name: light_history light_history_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.light_history
    ADD CONSTRAINT light_history_pk PRIMARY KEY (build_id);


--
-- Name: long_file_name long_file_name_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.long_file_name
    ADD CONSTRAINT long_file_name_pk PRIMARY KEY (hash);


--
-- Name: meta_file_line meta_file_line_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.meta_file_line
    ADD CONSTRAINT meta_file_line_pk PRIMARY KEY (file_name, line_nr);


--
-- Name: data_storage_dict metric_id_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.data_storage_dict
    ADD CONSTRAINT metric_id_pk PRIMARY KEY (metric_id);


--
-- Name: mute_info mute_info_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_info
    ADD CONSTRAINT mute_info_ak UNIQUE (project_int_id, mute_id);


--
-- Name: mute_info_bt mute_info_bt_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_info_bt
    ADD CONSTRAINT mute_info_bt_pk PRIMARY KEY (mute_id, build_type_id);


--
-- Name: mute_info mute_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_info
    ADD CONSTRAINT mute_info_pk PRIMARY KEY (mute_id);


--
-- Name: mute_info_problem mute_info_problem_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_info_problem
    ADD CONSTRAINT mute_info_problem_pk PRIMARY KEY (mute_id, problem_id);


--
-- Name: mute_info_test mute_info_test_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_info_test
    ADD CONSTRAINT mute_info_test_pk PRIMARY KEY (mute_id, test_name_id);


--
-- Name: mute_problem_in_bt mute_problem_in_bt_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_problem_in_bt
    ADD CONSTRAINT mute_problem_in_bt_pk PRIMARY KEY (mute_id, build_type_id, problem_id);


--
-- Name: mute_problem_in_proj mute_problem_in_proj_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_problem_in_proj
    ADD CONSTRAINT mute_problem_in_proj_pk PRIMARY KEY (mute_id, project_int_id, problem_id);


--
-- Name: mute_test_in_bt mute_test_in_bt_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_test_in_bt
    ADD CONSTRAINT mute_test_in_bt_pk PRIMARY KEY (mute_id, build_type_id, test_name_id);


--
-- Name: mute_test_in_proj mute_test_in_proj_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.mute_test_in_proj
    ADD CONSTRAINT mute_test_in_proj_pk PRIMARY KEY (mute_id, project_int_id, test_name_id);


--
-- Name: node_events node_events_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.node_events
    ADD CONSTRAINT node_events_pk PRIMARY KEY (node_id, id);


--
-- Name: node_locks node_locks_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.node_locks
    ADD CONSTRAINT node_locks_pk PRIMARY KEY (lock_type, id);


--
-- Name: node_tasks_long_value node_tasks_long_value_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.node_tasks_long_value
    ADD CONSTRAINT node_tasks_long_value_pk PRIMARY KEY (uuid);


--
-- Name: node_tasks node_tasks_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.node_tasks
    ADD CONSTRAINT node_tasks_pk PRIMARY KEY (id);


--
-- Name: node_tasks node_tasks_type_ident_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.node_tasks
    ADD CONSTRAINT node_tasks_type_ident_ak UNIQUE (task_type, task_identity, task_state);


--
-- Name: permanent_tokens permanent_token_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.permanent_tokens
    ADD CONSTRAINT permanent_token_pk PRIMARY KEY (id);


--
-- Name: personal_build_relative_path personal_build_relative_p_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.personal_build_relative_path
    ADD CONSTRAINT personal_build_relative_p_ak UNIQUE (build_id, original_path_hash);


--
-- Name: personal_vcs_change personal_vcs_changes_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.personal_vcs_change
    ADD CONSTRAINT personal_vcs_changes_pk PRIMARY KEY (modification_id, file_num);


--
-- Name: personal_vcs_history personal_vcs_history_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.personal_vcs_history
    ADD CONSTRAINT personal_vcs_history_ak UNIQUE (modification_hash);


--
-- Name: personal_vcs_history personal_vcs_history_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.personal_vcs_history
    ADD CONSTRAINT personal_vcs_history_pk PRIMARY KEY (modification_id);


--
-- Name: problem problem_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_ak UNIQUE (problem_type, problem_identity);


--
-- Name: problem problem_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_pk PRIMARY KEY (problem_id);


--
-- Name: project project_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_ak UNIQUE (config_id);


--
-- Name: project_files project_files_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_ak UNIQUE (file_name);


--
-- Name: project_files project_files_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_pk PRIMARY KEY (file_id);


--
-- Name: project_mapping project_mapping_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project_mapping
    ADD CONSTRAINT project_mapping_ak UNIQUE (ext_id);


--
-- Name: project_mapping project_mapping_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project_mapping
    ADD CONSTRAINT project_mapping_pk PRIMARY KEY (int_id, ext_id);


--
-- Name: project project_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pk PRIMARY KEY (int_id);


--
-- Name: removed_builds_history removed_builds_history_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.removed_builds_history
    ADD CONSTRAINT removed_builds_history_pk PRIMARY KEY (build_id);


--
-- Name: repository_state_branches repo_state_branches_idx; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.repository_state_branches
    ADD CONSTRAINT repo_state_branches_idx UNIQUE (vcs_root_id, branch_id);


--
-- Name: repository_state repo_state_vcs_root_idx; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.repository_state
    ADD CONSTRAINT repo_state_vcs_root_idx UNIQUE (vcs_root_id);


--
-- Name: responsibilities responsibilities_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.responsibilities
    ADD CONSTRAINT responsibilities_pk PRIMARY KEY (problem_id);


--
-- Name: running running_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.running
    ADD CONSTRAINT running_pk PRIMARY KEY (build_id);


--
-- Name: server_health_items server_health_items_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.server_health_items
    ADD CONSTRAINT server_health_items_pk PRIMARY KEY (id);


--
-- Name: server_property server_property_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.server_property
    ADD CONSTRAINT server_property_pk PRIMARY KEY (prop_name);


--
-- Name: stats stats_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pk PRIMARY KEY (build_id);


--
-- Name: stats_publisher_state stats_publisher_state_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.stats_publisher_state
    ADD CONSTRAINT stats_publisher_state_pk PRIMARY KEY (metric_id);


--
-- Name: test_failure_rate test_failure_rate_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_failure_rate
    ADD CONSTRAINT test_failure_rate_pk PRIMARY KEY (build_type_id, test_name_id);


--
-- Name: test_info_archive test_info_archive_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_info_archive
    ADD CONSTRAINT test_info_archive_pk PRIMARY KEY (build_id, test_id);


--
-- Name: test_info test_info_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_info
    ADD CONSTRAINT test_info_pk PRIMARY KEY (build_id, test_id);


--
-- Name: test_metadata_dict test_metadata_dict_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_metadata_dict
    ADD CONSTRAINT test_metadata_dict_ak UNIQUE (name_digest);


--
-- Name: test_metadata_dict test_metadata_dict_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_metadata_dict
    ADD CONSTRAINT test_metadata_dict_pk PRIMARY KEY (key_id);


--
-- Name: test_metadata test_metadata_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_metadata
    ADD CONSTRAINT test_metadata_pk PRIMARY KEY (build_id, test_id, key_id);


--
-- Name: test_metadata_types test_metadata_types_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_metadata_types
    ADD CONSTRAINT test_metadata_types_ak UNIQUE (name);


--
-- Name: test_metadata_types test_metadata_types_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_metadata_types
    ADD CONSTRAINT test_metadata_types_pk PRIMARY KEY (type_id);


--
-- Name: test_muted test_muted_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_muted
    ADD CONSTRAINT test_muted_pk PRIMARY KEY (build_id, test_name_id, mute_id);


--
-- Name: test_names test_names_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.test_names
    ADD CONSTRAINT test_names_pk PRIMARY KEY (id);


--
-- Name: permanent_tokens token_identifier_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.permanent_tokens
    ADD CONSTRAINT token_identifier_ak UNIQUE (identifier);


--
-- Name: permanent_token_permissions token_permissions_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.permanent_token_permissions
    ADD CONSTRAINT token_permissions_pk PRIMARY KEY (id, project_id, permission);


--
-- Name: permanent_tokens token_user_id_name_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.permanent_tokens
    ADD CONSTRAINT token_user_id_name_ak UNIQUE (user_id, name);


--
-- Name: users user_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_ak UNIQUE (username);


--
-- Name: user_attribute user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT user_attr_pk PRIMARY KEY (user_id, attr_key);


--
-- Name: user_blocks user_blocks_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_blocks
    ADD CONSTRAINT user_blocks_pk PRIMARY KEY (user_id, block_type);


--
-- Name: user_build_types_order user_bt_order_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_build_types_order
    ADD CONSTRAINT user_bt_order_pk PRIMARY KEY (user_id, project_int_id, bt_int_id);


--
-- Name: user_notification_data user_notif_data_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_notification_data
    ADD CONSTRAINT user_notif_data_pk PRIMARY KEY (user_id, rule_id);


--
-- Name: user_notification_events user_notification_events_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_notification_events
    ADD CONSTRAINT user_notification_events_pk PRIMARY KEY (id);


--
-- Name: users user_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: user_projects_order user_projects_order_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_projects_order
    ADD CONSTRAINT user_projects_order_pk PRIMARY KEY (user_id, project_int_id);


--
-- Name: user_projects_visibility user_projects_visibility_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_projects_visibility
    ADD CONSTRAINT user_projects_visibility_pk PRIMARY KEY (user_id, project_int_id);


--
-- Name: user_property user_property_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_property
    ADD CONSTRAINT user_property_pk PRIMARY KEY (user_id, prop_key);


--
-- Name: user_roles user_roles_ui; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_ui UNIQUE (user_id, role_id, project_int_id);


--
-- Name: usergroup_notification_events usergroup_notific_evnts_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_notification_events
    ADD CONSTRAINT usergroup_notific_evnts_pk PRIMARY KEY (id);


--
-- Name: usergroup_property usergroup_property_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_property
    ADD CONSTRAINT usergroup_property_pk PRIMARY KEY (group_id, prop_key);


--
-- Name: usergroup_roles usergroup_roles_ui; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_roles
    ADD CONSTRAINT usergroup_roles_ui UNIQUE (group_id, role_id, project_int_id);


--
-- Name: usergroup_subgroups usergroup_subgroups_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_subgroups
    ADD CONSTRAINT usergroup_subgroups_pk PRIMARY KEY (hostgroup_id, subgroup_id);


--
-- Name: usergroup_users usergroup_users_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroup_users
    ADD CONSTRAINT usergroup_users_pk PRIMARY KEY (group_id, user_id);


--
-- Name: usergroups usergroups_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_ak UNIQUE (name);


--
-- Name: usergroups usergroups_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pk PRIMARY KEY (group_id);


--
-- Name: data_storage_dict value_type_key_index; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.data_storage_dict
    ADD CONSTRAINT value_type_key_index UNIQUE (value_type_key);


--
-- Name: vcs_change_attrs vcs_change_attrs_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_change_attrs
    ADD CONSTRAINT vcs_change_attrs_pk PRIMARY KEY (modification_id, attr_name);


--
-- Name: vcs_change vcs_change_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_change
    ADD CONSTRAINT vcs_change_pk PRIMARY KEY (modification_id, file_num);


--
-- Name: vcs_changes_graph vcs_changes_graph_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_changes_graph
    ADD CONSTRAINT vcs_changes_graph_pk PRIMARY KEY (child_modification_id, parent_num);


--
-- Name: vcs_history vcs_history_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_history
    ADD CONSTRAINT vcs_history_pk PRIMARY KEY (modification_id);


--
-- Name: vcs_root vcs_root_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root
    ADD CONSTRAINT vcs_root_ak UNIQUE (config_id);


--
-- Name: vcs_root_first_revision vcs_root_first_revision_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root_first_revision
    ADD CONSTRAINT vcs_root_first_revision_pk PRIMARY KEY (build_type_id, parent_root_id, settings_hash);


--
-- Name: vcs_root_instance vcs_root_instance_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root_instance
    ADD CONSTRAINT vcs_root_instance_pk PRIMARY KEY (id);


--
-- Name: vcs_root_mapping vcs_root_mapping_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root_mapping
    ADD CONSTRAINT vcs_root_mapping_ak UNIQUE (ext_id);


--
-- Name: vcs_root_mapping vcs_root_mapping_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root_mapping
    ADD CONSTRAINT vcs_root_mapping_pk PRIMARY KEY (int_id, ext_id);


--
-- Name: vcs_root vcs_root_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_root
    ADD CONSTRAINT vcs_root_pk PRIMARY KEY (int_id);


--
-- Name: vcs_username vcs_username_ak; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_username
    ADD CONSTRAINT vcs_username_ak UNIQUE (user_id, vcs_name, parent_vcs_root_id, username);


--
-- Name: vcs_username vcs_username_pk; Type: CONSTRAINT; Schema: public; Owner: teamcity
--

ALTER TABLE ONLY public.vcs_username
    ADD CONSTRAINT vcs_username_pk PRIMARY KEY (user_id, vcs_name, parent_vcs_root_id, order_num);


--
-- Name: action_history_action_object_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX action_history_action_object_i ON public.action_history USING btree (action, object_id);


--
-- Name: action_history_comment; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX action_history_comment ON public.action_history USING btree (comment_id);


--
-- Name: action_history_object; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX action_history_object ON public.action_history USING btree (object_id);


--
-- Name: agent_agent_type_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX agent_agent_type_id ON public.agent USING btree (agent_type_id);


--
-- Name: agent_authorization_token; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX agent_authorization_token ON public.agent USING btree (authorization_token);


--
-- Name: agent_host_address; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX agent_host_address ON public.agent USING btree (host_addr);


--
-- Name: agent_type_bt_access_bt_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX agent_type_bt_access_bt_i ON public.agent_type_bt_access USING btree (build_type_id);


--
-- Name: agent_type_pool_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX agent_type_pool_i ON public.agent_type USING btree (agent_pool_id);


--
-- Name: audit_a_o_comment; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX audit_a_o_comment ON public.audit_additional_object USING btree (comment_id);


--
-- Name: backup_info_file_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX backup_info_file_i ON public.backup_info USING btree (file_name);


--
-- Name: bt_edge_relation_btid; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX bt_edge_relation_btid ON public.build_type_edge_relation USING btree (build_type_id);


--
-- Name: bt_grp_vcs_change_grp_mod_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX bt_grp_vcs_change_grp_mod_idx ON public.build_type_group_vcs_change USING btree (group_id, modification_id);


--
-- Name: bt_grp_vcs_change_mod_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX bt_grp_vcs_change_mod_idx ON public.build_type_group_vcs_change USING btree (modification_id);


--
-- Name: build_artif_dep_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_artif_dep_state_id ON public.build_artifact_dependency USING btree (build_state_id);


--
-- Name: build_attrs_name_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_attrs_name_idx ON public.build_attrs USING btree (attr_name);


--
-- Name: build_attrs_num_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_attrs_num_i ON public.build_attrs USING btree (attr_num_value, attr_name, build_state_id);


--
-- Name: build_checkout_rules_vroot_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_checkout_rules_vroot_i ON public.build_checkout_rules USING btree (vcs_root_id);


--
-- Name: build_dependency_ak; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_dependency_ak ON public.build_dependency USING btree (depends_on, build_state_id);


--
-- Name: build_labels_vcs_root_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_labels_vcs_root_i ON public.build_labels USING btree (vcs_root_id);


--
-- Name: build_orig_root_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_orig_root_index ON public.build_overriden_roots USING btree (original_vcs_root_id);


--
-- Name: build_problem_attr_p_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_problem_attr_p_id_idx ON public.build_problem_attribute USING btree (problem_id);


--
-- Name: build_problem_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_problem_id_idx ON public.build_problem USING btree (problem_id);


--
-- Name: build_problem_mute_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_problem_mute_id ON public.build_problem_muted USING btree (mute_id);


--
-- Name: build_project_project_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_project_project_idx ON public.build_project USING btree (project_int_id);


--
-- Name: build_queue_build_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_queue_build_state_id ON public.build_queue USING btree (build_state_id);


--
-- Name: build_revisions_mod_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_revisions_mod_id_i ON public.build_revisions USING btree (modification_id);


--
-- Name: build_revisions_vcs_root_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_revisions_vcs_root_i ON public.build_revisions USING btree (vcs_root_id);


--
-- Name: build_state_build_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_build_i ON public.build_state USING btree (build_id, is_deleted, branch_name, is_personal);


--
-- Name: build_state_build_type_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_build_type_i ON public.build_state USING btree (build_type_id, is_deleted, branch_name, is_personal);


--
-- Name: build_state_mod_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_mod_i ON public.build_state USING btree (modification_id);


--
-- Name: build_state_pmod_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_pmod_i ON public.build_state USING btree (personal_modification_id);


--
-- Name: build_state_private_tag_ie1; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_private_tag_ie1 ON public.build_state_private_tag USING btree (owner, build_state_id);


--
-- Name: build_state_puser_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_puser_i ON public.build_state USING btree (personal_user_id);


--
-- Name: build_state_rem_queue_time_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_rem_queue_time_i ON public.build_state USING btree (remove_from_queue_time);


--
-- Name: build_state_tag_ie1; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_state_tag_ie1 ON public.build_state_tag USING btree (tag, build_state_id);


--
-- Name: build_subst_root_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_subst_root_index ON public.build_overriden_roots USING btree (substitution_vcs_root_id);


--
-- Name: build_type_vcs_change_btid; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX build_type_vcs_change_btid ON public.build_type_vcs_change USING btree (build_type_id);


--
-- Name: co_build_id_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX co_build_id_index ON public.compiler_output USING btree (build_id);


--
-- Name: comments_when_changed_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX comments_when_changed_i ON public.comments USING btree (when_changed);


--
-- Name: config_persisting_tasks_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX config_persisting_tasks_ie ON public.config_persisting_tasks USING btree (task_type, stage);


--
-- Name: custom_data_body_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX custom_data_body_id_idx ON public.custom_data USING btree (data_id);


--
-- Name: custom_data_body_ud_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX custom_data_body_ud_idx ON public.custom_data_body USING btree (update_date);


--
-- Name: custom_data_domain_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX custom_data_domain_idx ON public.custom_data USING btree (data_domain);


--
-- Name: def_build_params_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX def_build_params_state_id ON public.default_build_parameters USING btree (build_state_id);


--
-- Name: downloaded_artifacts_source_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX downloaded_artifacts_source_id ON public.downloaded_artifacts USING btree (source_build_id);


--
-- Name: downloaded_artifacts_ts_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX downloaded_artifacts_ts_id ON public.downloaded_artifacts USING btree (target_build_id, source_build_id);


--
-- Name: duplicate_fragments_file_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX duplicate_fragments_file_i ON public.duplicate_fragments USING btree (file_id);


--
-- Name: duplicate_mods_mod_id_date_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX duplicate_mods_mod_id_date_i ON public.duplicate_vcs_modification USING btree (modification_id, register_date);


--
-- Name: duplicate_mods_orig_mod_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX duplicate_mods_orig_mod_id_i ON public.duplicate_vcs_modification USING btree (orig_modification_id);


--
-- Name: duplicate_mods_r_id_mod_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX duplicate_mods_r_id_mod_id_i ON public.duplicate_vcs_modification USING btree (vcs_root_id, modification_id);


--
-- Name: duplicate_results_build_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX duplicate_results_build_i ON public.duplicate_results USING btree (build_id);


--
-- Name: failed_tests_build_idx2; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX failed_tests_build_idx2 ON public.failed_tests USING btree (build_id);


--
-- Name: failed_tests_ffi_build_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX failed_tests_ffi_build_idx ON public.failed_tests USING btree (ffi_build_id);


--
-- Name: final_artif_dep_src_bt_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX final_artif_dep_src_bt_id ON public.final_artifact_dependency USING btree (source_build_type_id);


--
-- Name: final_artif_dep_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX final_artif_dep_state_id ON public.final_artifact_dependency USING btree (build_state_id);


--
-- Name: group_notif_data_rule_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX group_notif_data_rule_id ON public.usergroup_notification_data USING btree (rule_id);


--
-- Name: group_watch_type_rule_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX group_watch_type_rule_id ON public.usergroup_watch_type USING btree (rule_id);


--
-- Name: health_item_id_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX health_item_id_ie ON public.hidden_health_item USING btree (item_id);


--
-- Name: history_agent_finish_time_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_agent_finish_time_i ON public.history USING btree (agent_name, build_finish_time_server);


--
-- Name: history_agent_type_b_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_agent_type_b_id_i ON public.history USING btree (agent_type_id, build_id);


--
-- Name: history_bt_id_rm_from_q_time; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_bt_id_rm_from_q_time ON public.history USING btree (build_type_id, remove_from_queue_time);


--
-- Name: history_build_number_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_build_number_i ON public.history USING btree (build_number);


--
-- Name: history_build_state_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_build_state_id_i ON public.history USING btree (build_state_id);


--
-- Name: history_build_type_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_build_type_id_i ON public.history USING btree (build_type_id, branch_name, is_canceled, pin);


--
-- Name: history_finish_time_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_finish_time_idx ON public.history USING btree (build_finish_time_server);


--
-- Name: history_remove_from_q_time_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_remove_from_q_time_i ON public.history USING btree (remove_from_queue_time);


--
-- Name: history_start_time_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX history_start_time_idx ON public.history USING btree (build_start_time_server);


--
-- Name: ids_group_entity_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX ids_group_entity_id_idx ON public.ids_group_entity_id USING btree (entity_id);


--
-- Name: ids_group_hash_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX ids_group_hash_idx ON public.ids_group USING btree (group_hash);


--
-- Name: ids_group_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX ids_group_idx ON public.ids_group_entity_id USING btree (group_id, entity_id);


--
-- Name: ignored_tests_build_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX ignored_tests_build_id ON public.ignored_tests USING btree (build_id);


--
-- Name: inspection_data_file_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_data_file_index ON public.inspection_data USING btree (file_name);


--
-- Name: inspection_data_insp_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_data_insp_index ON public.inspection_data USING btree (inspection_id);


--
-- Name: inspection_diff_hash_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_diff_hash_index ON public.inspection_diff USING btree (hash);


--
-- Name: inspection_fixes_hash_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_fixes_hash_index ON public.inspection_fixes USING btree (hash);


--
-- Name: inspection_results_buildhash_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_results_buildhash_i ON public.inspection_results USING btree (build_id, hash);


--
-- Name: inspection_results_hash_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX inspection_results_hash_index ON public.inspection_results USING btree (hash);


--
-- Name: light_history_agt_b_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX light_history_agt_b_i ON public.light_history USING btree (agent_type_id, build_id);


--
-- Name: light_history_finish_time_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX light_history_finish_time_i ON public.light_history USING btree (build_finish_time_server);


--
-- Name: metric_key_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX metric_key_index ON public.server_statistics USING btree (metric_key, metric_timestamp);


--
-- Name: mute_info_bt_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_info_bt_ie ON public.mute_info_bt USING btree (build_type_id);


--
-- Name: mute_problem_in_bt_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_problem_in_bt_ie ON public.mute_problem_in_bt USING btree (build_type_id, problem_id, mute_id);


--
-- Name: mute_problem_in_proj_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_problem_in_proj_ie ON public.mute_problem_in_proj USING btree (project_int_id, problem_id, mute_id);


--
-- Name: mute_test_in_bt_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_test_in_bt_ie ON public.mute_test_in_bt USING btree (build_type_id, test_name_id, mute_id);


--
-- Name: mute_test_in_bt_tn_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_test_in_bt_tn_ie ON public.mute_test_in_bt USING btree (test_name_id);


--
-- Name: mute_test_in_proj_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_test_in_proj_ie ON public.mute_test_in_proj USING btree (project_int_id, test_name_id, mute_id);


--
-- Name: mute_test_in_proj_tn_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX mute_test_in_proj_tn_ie ON public.mute_test_in_proj USING btree (test_name_id);


--
-- Name: node_events_created_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX node_events_created_idx ON public.node_events USING btree (created);


--
-- Name: node_locks_node_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX node_locks_node_id_idx ON public.node_locks USING btree (node_id, id, lock_type);


--
-- Name: node_tasks_task_state_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX node_tasks_task_state_idx ON public.node_tasks USING btree (task_state);


--
-- Name: notification_events_notifier; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX notification_events_notifier ON public.user_notification_events USING btree (notificator_type);


--
-- Name: notification_events_user_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX notification_events_user_id ON public.user_notification_events USING btree (user_id);


--
-- Name: order_num_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX order_num_idx ON public.test_names USING btree (order_num);


--
-- Name: permanent_t_exp_t_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX permanent_t_exp_t_idx ON public.permanent_tokens USING btree (expiration_time);


--
-- Name: permanent_t_p_pr_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX permanent_t_p_pr_id_idx ON public.permanent_token_permissions USING btree (project_id);


--
-- Name: personal_vcs_history_user_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX personal_vcs_history_user_i ON public.personal_vcs_history USING btree (user_id);


--
-- Name: remember_me_secure_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX remember_me_secure_idx ON public.remember_me USING btree (secure);


--
-- Name: remember_me_uk_secure_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX remember_me_uk_secure_idx ON public.remember_me USING btree (user_key, secure);


--
-- Name: removed_b_agent_buildid; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX removed_b_agent_buildid ON public.removed_builds_history USING btree (agent_type_id, build_id);


--
-- Name: removed_b_history_finish_time; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX removed_b_history_finish_time ON public.removed_builds_history USING btree (build_finish_time_server);


--
-- Name: removed_b_start_time_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX removed_b_start_time_index ON public.removed_builds_history USING btree (build_start_time_server);


--
-- Name: removed_b_stats_optimized_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX removed_b_stats_optimized_i ON public.removed_builds_history USING btree (build_type_id, status, is_canceled, branch_name);


--
-- Name: responsibilities_assignee; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX responsibilities_assignee ON public.responsibilities USING btree (responsible_user_id);


--
-- Name: responsibilities_reporter; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX responsibilities_reporter ON public.responsibilities USING btree (reporter_user_id);


--
-- Name: running_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX running_state_id ON public.running USING btree (build_state_id);


--
-- Name: server_health_items_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX server_health_items_ie ON public.server_health_items USING btree (report_id, category_id);


--
-- Name: start_time_index_light; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX start_time_index_light ON public.light_history USING btree (build_start_time_server);


--
-- Name: stats_optimized_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX stats_optimized_index ON public.light_history USING btree (build_type_id, status, is_canceled, branch_name);


--
-- Name: test_archive_name_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX test_archive_name_id_idx ON public.test_info_archive USING btree (test_name_id);


--
-- Name: test_failure_rate_tn_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX test_failure_rate_tn_idx ON public.test_failure_rate USING btree (test_name_id);


--
-- Name: test_metadataname_name_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX test_metadataname_name_idx ON public.test_metadata USING btree (test_name_id);


--
-- Name: test_muted_mute_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX test_muted_mute_id ON public.test_muted USING btree (mute_id);


--
-- Name: test_name_id_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX test_name_id_idx ON public.test_info USING btree (test_name_id);


--
-- Name: user_attr_key_value_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_attr_key_value_idx ON public.user_attribute USING btree (attr_key, locase_value_hash);


--
-- Name: user_build_params_state_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_build_params_state_id ON public.user_build_parameters USING btree (build_state_id);


--
-- Name: user_build_types_order_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_build_types_order_i ON public.user_build_types_order USING btree (project_int_id);


--
-- Name: user_notif_data_rule_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_notif_data_rule_id ON public.user_notification_data USING btree (rule_id);


--
-- Name: user_projects_order_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_projects_order_i ON public.user_projects_order USING btree (project_int_id);


--
-- Name: user_projects_visibility_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_projects_visibility_i ON public.user_projects_visibility USING btree (project_int_id);


--
-- Name: user_property_key_value_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_property_key_value_idx ON public.user_property USING btree (prop_key, locase_value_hash);


--
-- Name: user_roles_p_int_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_roles_p_int_id_i ON public.user_roles USING btree (project_int_id);


--
-- Name: user_watch_type_pk; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX user_watch_type_pk ON public.user_watch_type USING btree (user_id, notificator_type, watch_type, watch_value);


--
-- Name: usergroup_events_group_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX usergroup_events_group_id ON public.usergroup_notification_events USING btree (group_id);


--
-- Name: usergroup_events_notifier; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX usergroup_events_notifier ON public.usergroup_notification_events USING btree (notificator_type);


--
-- Name: usergroup_roles_p_int_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX usergroup_roles_p_int_id_i ON public.usergroup_roles USING btree (project_int_id);


--
-- Name: usergroup_watch_type_pk; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX usergroup_watch_type_pk ON public.usergroup_watch_type USING btree (group_id, notificator_type, watch_type, watch_value);


--
-- Name: vcs_changes_graph_parent_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_changes_graph_parent_i ON public.vcs_changes_graph USING btree (parent_modification_id);


--
-- Name: vcs_changes_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_changes_index ON public.vcs_changes USING btree (modification_id);


--
-- Name: vcs_history_date_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_history_date_i ON public.vcs_history USING btree (register_date);


--
-- Name: vcs_history_root_id_mod_id_i; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_history_root_id_mod_id_i ON public.vcs_history USING btree (vcs_root_id, modification_id);


--
-- Name: vcs_personal_changes_index; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_personal_changes_index ON public.personal_vcs_changes USING btree (modification_id);


--
-- Name: vcs_root_instance_parent_idx; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_root_instance_parent_idx ON public.vcs_root_instance USING btree (parent_id, settings_hash);


--
-- Name: vcs_username_user_ie; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX vcs_username_user_ie ON public.vcs_username USING btree (vcs_name, parent_vcs_root_id, username);


--
-- Name: watch_type_rule_id; Type: INDEX; Schema: public; Owner: teamcity
--

CREATE INDEX watch_type_rule_id ON public.user_watch_type USING btree (rule_id);


--
-- PostgreSQL database dump complete
--

