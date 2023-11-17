Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB41D266
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tBGCQ2iC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eeceub2MK1WX3WCbkAcIaau1aCaCgt+9HcsQoZTh0/9Iwp2mkzHqvpwtNKU04D3Z/1CuVYxRbdDfiNktIE5KpnRjC4tr7Sboma1HflwX8gOZ7POAldZlO+7JxmDFTide3Igu9e7Hndm5AZOE7egjXBB7gfCEAkCRqh/+k9PG3LUCuM9L/6yV33QIESPEoZUkC5lFqK6apevbESECu8MhgRt9etxZx+FgDnfbNUuNTCMwBXQnP9fBMV6br3N2HJyObWQEHOs7X9ULhUwoCGDeRUEHArWw4REZtToh4HMlJjDEIbktX1zLekBZc3S5q5HZk/m4hvxJUwQcQ6KXe2jwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bOSNUkBevLRYuX8PLlUocKHZaLtu5kYwlFPQ37mzpA=;
 b=kfJB0DQhmI8ho5BAGlC3N2KAMxc0g025ZUH1H3uLVwOYNDFm3cdq4btJybkeiuAbFC9pqKgGkTlYxx0Mw53159UUTNIq1NKMzBKzhQML2eJPrzGpKUyzVyeRTzAltBJYv/dVI9e5fEJMKIipaIukfnSqu4yRCPSEUwNAn0i+PsliaCRL5TsvOa4RPJfFyh7YB3i0muAXhFC1A9a2XeDlL2km93rKYZIdO0+DXa9QwyA2GyEKJbJWFq4hN96Cs+RfSCD1yHkOYaJs3qojcaKsBCviMLAEYOXkMFU7pIzPXQUzwGbHfpYp/F1XrHYSZPBtejdGyoft1QztLliUtV631g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bOSNUkBevLRYuX8PLlUocKHZaLtu5kYwlFPQ37mzpA=;
 b=tBGCQ2iCx//s10fnmZ6TWPCOEwgnvommMb1Ig0xLBV4qvhtM4qNFB/Hp/sWD3yTDUQU+skeOvR+zYXcCAOHDss/qjAwAwBP4xTeSxuALHDqjqYyYLzkbLRw0UkErneak/ZtzUPLFNMbGcXfCrV9QPcMYs44px0ymaM6jGqNBiQ9swuEuOeZyAExIdkzaoPruwChwoy8DPUYUbG8nccvz/Pm4bMPIwjR/DgXe1Ab32udy9mASxz+Nu7hSivrxf501iiRUCdxqt9dt7FRYrryU1l+gsqB3qfxzKAQJA06VBkmKaUsWIHRYpL+yQXP3443rdod29H9ZvWoa4Se5olJy9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.11; Fri, 17 Nov
 2023 05:32:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 05:32:50 +0000
Date: Fri, 17 Nov 2023 13:33:05 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: join: fix
 subflow_send_ack lookup
Message-ID: <20231117053305.GA26319@localhost.localdomain>
References: <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 787bb11d-9f3e-4dfa-7c19-08dbe72ea2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sJDjHvmxb8NhsrAx24r+l4/TFgPJe+Ae1SIbhswhJDIMnej9vIc6kYnSsc0kGqsauPNyq/ChOWXU1Rf7h2lpB0yLmuuRCnpVMsAvG1OmLLIw4375Eif7ki8NG+FLkfGzCw1H0NhfcokSu0+CbKdFrhOlaxrVgWx7Nt4Rlnbz9GtgbKkBYdKWgNzTT+GGRM+w5wzsBvvReBBIbAoOWbOwHnyH+KF8lEDdwoPjGskLJPkn+A4sAI7ALnuWGV9BoC2tT7yKqG0W0ZJZITB93z5sovRxqMcNJcrYijPqpeZ2XT/iKyRaitXzQXvUYiU9mXc9wjSiq3ZFPW4VcSVgD3mt1QwdrTBPjQwuE3xzgrzjc/MX8mCJpskN4d+e/nWwECgoigAZIV7vUgzuil30zJiBbAH3AVAtbI7CaIrSsoV488z5VjPT8gbmC8IB8jjDZM6Azt0a52tEaEl4CE1ZoSgA/g7FMlmb9BXUzveAsCHpGJVxyY6usYdVFIQv2GJZA2EZmHhWI24FJk7uJw8XqOSslodGVGBJx2OSHofFcxJcFD68V/ePkPRLtZSb+hkkNP6g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(86362001)(5660300002)(1076003)(8936002)(8676002)(44832011)(83380400001)(41300700001)(33656002)(26005)(2906002)(6512007)(66476007)(66556008)(66946007)(9686003)(6916009)(316002)(6506007)(6486002)(38100700002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uIhsbfC3lE9qbAKbf6mJ+zXwE5aG+AwU7EgXKgBQvLY8pd5MbxNLm8KFoU7L?=
 =?us-ascii?Q?FpxNAlkMdeFXf+jyHoGgSnBLwh6fsAm/dL3FLSIMEANPtTGnMEjpbfy9DPMq?=
 =?us-ascii?Q?yKAixWycN4+YSYDeWmOLaCCf/JNXrpKLXHdvQfdpNP7ORAgEBNfSMyBJlsZt?=
 =?us-ascii?Q?YfWz9oxQoQwjfTn74v6fve4dXs9FCbgqTueRtymNCMgsCimNCml6nL73rWD4?=
 =?us-ascii?Q?BAvcKw9UGC0bVUcK1aL6t/UAd99rFL5RRnk0F8ygjs5kgK0dBwE1EW1ND8BB?=
 =?us-ascii?Q?NK8ZdAT7Y7haXhkY3g910RFrnHli1JFX9Iw/91QQxPUaKcLZ6WaAwoZDtekH?=
 =?us-ascii?Q?STGG9+oZL7tRZXsffPpkHAPUkf/fWNSbde7XbFvOcG8nHOe93N0bcIAdhFvO?=
 =?us-ascii?Q?d8tXiL2S/5dcs9/DJX4VKBSY+ZrtzpEPt3V9Lwh/SMnWX0ChMt2nE9ID6cUY?=
 =?us-ascii?Q?oG0cfiloX15fZr4QZUFB0u8l0UHA14YPEjLX4W0DYr44hNWSXmwVQo7nY12J?=
 =?us-ascii?Q?CuZ8XiLnGLAdHw2z1AOSSlX2dvl19xQSnExTXId1eGlzOgns6anlX00mrLrF?=
 =?us-ascii?Q?k+O6zTzFr0OyY1uUhHgLM/Hb5xyBvsEP5phBVuVjXduhs9J3LiNKGZQUHk0/?=
 =?us-ascii?Q?WPnjfHyvDRzWrbXZtib9FR2Xpfz37sAexUqtVIb3MWPwBWBgQxTM1uvBbpEP?=
 =?us-ascii?Q?AUX9oY4XxE/NWO4m/Kwl4kyDSHse6yv+TxAElJJaUr+v4SXoce/1fDIUXVfg?=
 =?us-ascii?Q?uixifysKQCok9CoON+kRO050530q4SAnJK9VZfeGviGX3uYAwkVpeQpIbTPC?=
 =?us-ascii?Q?yYK6rxqDdog4vwT0Px1HOPolDkhyxnrapChGUhwK179wYpUEQ+BF+ZdMqhyc?=
 =?us-ascii?Q?hz+z7OoOAu7BKyQqvvHjvni6V+JGAQCktjFuSoHWdGIYAOOvjSUWYEadoKwY?=
 =?us-ascii?Q?sN4bJjP2l8Cl21JzUeSSoFV9nCN/2z87DCrrabUU+zsMcwX7gqC2D24l8lD3?=
 =?us-ascii?Q?cRJIcJnib2Gbqj3pBnYsmp74dliWTBLCcHITkPVgGuCH3wFo6GdmdvwlbqfZ?=
 =?us-ascii?Q?wHpf8lmvzzdx/x4B4bPFqUfzTyfBKI+U/owMQImeFARRfVOXi3Z+vmsnQzUX?=
 =?us-ascii?Q?J/JbYzB4dUjDYsTKTOsEjK7cKBrMFfnKOkncVc2l5HZrYJ3Ue4j3n2BaDnms?=
 =?us-ascii?Q?xVliqf1Q1MqZv99n1lQHhv8+MXjuzF744XEiC/HQD3hjAaNGCYcxcRwcLuNA?=
 =?us-ascii?Q?b5mIe9hfynwQ91Zpou4NKG0dsXyteETlNTI9IOzbdwPMVf7XQ8T+vWTD5GFI?=
 =?us-ascii?Q?KW3IdfSqlEjEsB3eSPx8o5zJsrExPqO0Nm/kT7ibx1Z37moVdS1oBSRBNY31?=
 =?us-ascii?Q?NZCebegwHtQWRE0CjEQ5pLme0nZerGbHEELfSnlVGT3INDR8hUmJ1TTWevBR?=
 =?us-ascii?Q?29mD9wZTPdDluKhCi7CITodPCg/Q/t6jq3W9Z3xy5pkazB9lfE8UtsXfyhJY?=
 =?us-ascii?Q?seM71ZHWJdSIF+GbY1yb2kKXUjVYrV0O3UbaMvVdIIf1x48D0IUWhePqrViS?=
 =?us-ascii?Q?fPZuxPIJzbb9SwZX5R/lCJniZW2RkBTozhPzafxk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787bb11d-9f3e-4dfa-7c19-08dbe72ea2b4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 05:32:49.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLTbGQgYcMb+LsdUrmr1F5chyP56wx0KhcqAmCuWhEG8UQUS07jwPeS2vzKU3uWsgtzHPyjfGzzyjUlykdUOXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

On Tue, Nov 14, 2023 at 10:57:08PM +0800, Geliang Tang wrote:
> MPC backups tests will skip unexpected sometimes, since static functions
> like mptcp_subflow_send_ack may also be listed in /proc/kallsyms, with a
> 't' in front of it, not 'T' ('T' is for a global function):
> 
>  > grep "mptcp_subflow_send_ack" /proc/kallsyms
> 
>  0000000000000000 T __pfx___mptcp_subflow_send_ack
>  0000000000000000 T __mptcp_subflow_send_ack
>  0000000000000000 t __pfx_mptcp_subflow_send_ack
>  0000000000000000 t mptcp_subflow_send_ack

I did some tests again, and found that whether to list the static
functions in /proc/kallsyms depends on the version of gcc:

Use gcc-8, "t mptcp_subflow_send_ack" is in /proc/kallsyms.

> sudo dmesg | head
[    0.000000] Linux version 6.6.0-mptcp+ (tgl@localhost.localdomain) (gcc (SUSE Linux) 8.5.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.39.0.20220810-150100.7.40) #5 SMP PREEMPT_DYNAMIC Thu Nov 16 10:27:33 CST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-mptcp+ root=/dev/mapper/vg0-lvol0 splash=silent mitigations=auto quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006a5b6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006a5b7000-0x000000006e794fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006e795000-0x000000006fb1efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006fb1f000-0x000000006fc4efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006fc4f000-0x000000006fc4ffff] usable

> sudo cat /proc/kallsyms | grep subflow_send_ack
ffffffffa1c0df80 T __pfx___mptcp_subflow_send_ack
ffffffffa1c0df90 T __mptcp_subflow_send_ack
ffffffffa1c0dfd0 t __pfx_mptcp_subflow_send_ack
ffffffffa1c0dfe0 t mptcp_subflow_send_ack

Use gcc-11, no mptcp_subflow_send_ack is in /proc/kallsyms.

> sudo dmesg | head
[sudo] password for root:
[    0.000000] Linux version 6.6.0-mptcp+ (tgl@bogon) (gcc (SUSE Linux) 11.4.1 20230630 [revision f03b182f7f23e14d587cfa1daec13ef7c3044ac0], GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.39.0.20220810-150100.7.40) #25 SMP PREEMPT_DYNAMIC Thu Nov 16 22:26:41 CST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-mptcp+ root=/dev/mapper/vg0-lvol0 splash=silent mitigations=auto quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006a5b6fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006a5b7000-0x000000006e794fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006e795000-0x000000006fb1efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006fb1f000-0x000000006fc4efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006fc4f000-0x000000006fc4ffff] usable
> sudo cat /proc/kallsyms | grep subflow_send_ack
ffffffffaca54e80 T __pfx___mptcp_subflow_send_ack
ffffffffaca54e90 T __mptcp_subflow_send_ack

So MPC backups tests will skip unexpected when using gcc-8. This patch
does fix this issue. Only commit log needs to be updated:

'''
MPC backups tests will skip unexpected sometimes (For example, when
compiling kernel with an older version of gcc, such as gcc-8), since
static functions like mptcp_subflow_send_ack also be listed in
/proc/kallsyms, with a 't' in front of it, not 'T' ('T' is for a global
function):

 > grep "mptcp_subflow_send_ack" /proc/kallsyms

 0000000000000000 T __pfx___mptcp_subflow_send_ack
 0000000000000000 T __mptcp_subflow_send_ack
 0000000000000000 t __pfx_mptcp_subflow_send_ack
 0000000000000000 t mptcp_subflow_send_ack

In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
will be false, MPC backups tests will skip. This is not what we expected.

The correct logic here should be: if mptcp_subflow_send_ack is not a
global function in /proc/kallsyms, do these MPC backups tests. So a 'T'
must be added in front of mptcp_subflow_send_ack.
'''

Thanks,
-Geliang

> 
> In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
> will be false, MPC backups tests will skip. This is not what we expected.
> 
> The correct logic here should be: if mptcp_subflow_send_ack is not a
> global function in /proc/kallsyms, do these MPC backups tests. So a 'T'
> must be added in front of mptcp_subflow_send_ack.
> 
> Fixes: 632978f0a961 ("selftests: mptcp: join: skip MPC backups tests if not supported")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
>  - Update commit log, fix typos in it.
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1606474232f6..6fbc70332caa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2755,7 +2755,7 @@ backup_tests()
>  	fi
>  
>  	if reset "mpc backup" &&
> -	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
> +	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2764,7 +2764,7 @@ backup_tests()
>  	fi
>  
>  	if reset "mpc backup both sides" &&
> -	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
> +	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
>  		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
>  		speed=slow \
> @@ -2774,7 +2774,7 @@ backup_tests()
>  	fi
>  
>  	if reset "mpc switch to backup" &&
> -	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
> +	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
>  		sflags=backup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> @@ -2783,7 +2783,7 @@ backup_tests()
>  	fi
>  
>  	if reset "mpc switch to backup both sides" &&
> -	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
> +	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
>  		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
>  		sflags=backup speed=slow \
> -- 
> 2.35.3
> 
