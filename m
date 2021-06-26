Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23266D0F
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 00:19:46 +0000 (UTC)
IronPort-SDR: 4oNWWrBCeLZskHe+q1mgcD+h4kcapJW9u9IZ6lIkOV9J8KWBhIukhzcx10D/IrtxMYnwu1stZz
 tH4ZoCj/B5Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="188140607"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="188140607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:19:46 -0700
IronPort-SDR: cVmOajaZV5+SggrCUdBzGJfCZVhEiPkRYzhGs4OhlToCKMQ7YSqs9ump8hUYnBu1GpNcKZZU2h
 aY9Z8oHqGotw==
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="407122451"
Received: from vsampat1-mobl2.amr.corp.intel.com ([10.212.210.249])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:19:45 -0700
Date: Fri, 25 Jun 2021 17:19:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: add the mibs for
 MP_FAIL
In-Reply-To: <a19dbf57d8d1a44e1bf3314f95b1e6023ede46f9.1624535762.git.geliangtang@gmail.com>
Message-ID: <c09560a2-c6d2-7c91-449f-939da6796a4a@linux.intel.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
 <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com> <a19dbf57d8d1a44e1bf3314f95b1e6023ede46f9.1624535762.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 24 Jun 2021, Geliang Tang wrote:

> This patch added the mibs for MP_FAIL: MPTCP_MIB_MPFAILTX and
> MPTCP_MIB_MPFAILRX.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/mib.c     | 2 ++
> net/mptcp/mib.h     | 2 ++
> net/mptcp/options.c | 1 +
> net/mptcp/pm.c      | 1 +
> net/mptcp/subflow.c | 1 +
> 5 files changed, 7 insertions(+)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 52ea2517e856..3f0df09138b2 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
> 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
> 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
> 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
> +	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
> +	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
> 	SNMP_MIB_SENTINEL
> };
>
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 193466c9b549..2a6cb1d8704c 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
> 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
> 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
> 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
> +	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
> +	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
> 	__MPTCP_MIB_MAX
> };
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cd4d0521556d..5442ca39b3eb 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1136,6 +1136,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>
> 	if (mp_opt.mp_fail) {
> 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> 		mp_opt.mp_fail = 0;
> 	}
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7792f6e38ba..d74eb56043c3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -9,6 +9,7 @@
> #include <net/tcp.h>
> #include <net/mptcp.h>
> #include "protocol.h"
> +#include "mib.h"
>
> /* path manager command handlers */
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 13e53a6bd3a1..1228ed275a9f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -914,6 +914,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
> 	if (unlikely(csum_fold(csum))) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> 		subflow->send_mp_fail = 1;
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);

Looks like MPTCP_MIB_DATACSUMERR and MPTCP_MIB_MPFAILTX will always be 
exactly the same, do we need the new one?

> 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
> 	}
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
