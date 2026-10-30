Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335432;
	b=aRoc0ZNlXajBxv9+YlgCUtIRSul0MgwvX+kqgQH8cejfInSJpoQGjsAkzpxQRwk6QAmX
	 Sfy0wdGSqkb5rNPbV1ufavD+AGWVw8KkKw3n+AN7i7DxPAPdcpivfbu5OOe73KMu9iKAE
	 SGO37L6umlwXdaTeOINpMb5wYhzxEG6FmbO7m+RcSJ28wVACPxwTcyzkuEt9H8UpXv22S
	 2c34dkbjp5rr0g4cQ1k5TgwPcktb7OV5ejhL8yiZjaRnYzVhGoEAP8ijpVDHq+hK5dugc
	 bl7Crkz+jSOs7BDm1qwy6k3oHIgp51ihk2pnxqHqo9z+aUruhY7OztLY4b8Bf6eaysw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335432;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version;
	bh=OvOXSPXZIRu6O3EXDBUqMrVNv/wJqmBJ8RFVRmHGW0U=;
	b=RWmwpY1Y8oOADFFavU41QS5jEfW4daq/Cr6JtUKiWAAV0b8C7xjdAD2e7UXBplj9Wgfj
	 NxhU0+dVgCDVnzAE5o85RLfqNUC3KZQ03KSfRyWPPDSaKMGdv+dHBcl1jI9Lla75INkfu
	 IuBE08GnY3B99vm5qiAujyzkIHXiozTifhFQ3+81/w1NvPmzsH1IHUqH1mcAaFDiqxfsw
	 7MkGxps4doYYGfGXIw/m5V6QoV4Vq76FhepqbbHmvV6D7MDzt6JSLHLiK1F1rT11wRz0d
	 GQps6Vfj2I5MjJg5J7pPu3VD4fk9fKmEb6RUruGaLamXljGn6i1G94IBWbAEjoxziYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KceRpDB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690D606A31F
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KceRpDB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866931F000C1;
	Fri, 30 Oct 2026 04:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793335431;
	bh=OvOXSPXZIRu6O3EXDBUqMrVNv/wJqmBJ8RFVRmHGW0U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KceRpDB2z54Qc88Hy8Gw4s+0uRMRH4s9cRL1zEpAmuYTrfRPYjjB7hKhJABvz+R5n
	 7Pu6B5zATL9afQWt3QcVgtgSLtEnXW3kbjKKfdNS4xXaEThgU/2evv2DM7t+z/7v/z
	 QxXL8B9/RF8lOr0bTsTLN6LqGVBmWWL8NjydfJxswcrG5YR4hAxs+P+3BJUyJ9l6Ro
	 vzE2GpV1c0ZyXwBVL9gGPy0XPRx6IODSAwb5ADBu3gIrjxxa4gnw6OXisgpgeKdPk7
	 UP/LIOU2aPR3cfiW+FQ0S407hxUpnifEsZEtYJH1sjfcZSzUKo28lNQSVF6B4tM19i
	 W+3S8zFGbJM/Q==
Message-ID: <7ef983a66bc3303f33a95db8fe112024175a45f9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: reject MP_JOIN earlier
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Chenguang Zhao
 <chenguang.zhao@linux.dev>,  Gang Yan <gang.yan@linux.dev>
Date: Fri, 30 Oct 2026 12:43:45 +0800
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
	 <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
Content-Type: multipart/mixed; boundary="=-KA/JCpe63bQv7Rj5DhFv"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

--=-KA/JCpe63bQv7Rj5DhFv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-10-30 at 00:21 +0100, Matthieu Baerts (NGI0) wrote:
> When a SYN + MP_JOIN is received, it is good to check directly if the
> MP_JOIN is allowed, then checking that later at the establishment of
> the
> new subflow.
> 
> This avoids situations where the 3WHS is done, then the joined
> subflow
> is rejected.
> 
> This changes the behaviour, and the new behaviour is tracked with the
> MPJoinDisallowed MIB counter.
> 
> Note that in the selftests, we need to support older kernels not
> following this new behaviour. For that, we can check if the new
> counter
> is present: if it is, the join rejected counter should be used
> instead,
> and we should see more SYN+ACK. One exception for the SYN cookies
> case
> were the reject was already done early but MPJoinRejected was used
> instead.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  - Explain that mptcp_can_accept_new_subflow() is racy, but OK.
> (Paolo)
>  - support older kernels with the previous behaviour.
>  - no more special case for syncookie, switch to new counter.
>  - s/MPJoinDisallow/MPJoinDisallowed/ (+ ed). (Sashiko)
> ---
>  net/mptcp/mib.c                                 |  1 +
>  net/mptcp/mib.h                                 |  1 +
>  net/mptcp/subflow.c                             | 31 +++++++++-----
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 55
> +++++++++++++++++++------
>  4 files changed, 64 insertions(+), 24 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 608cb568897c..b1710082bbca 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -34,6 +34,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
>  	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
>  	SNMP_MIB_ITEM("MPJoinNotEstablished",
> MPTCP_MIB_MPJOINNOTESTABLISHED),
> +	SNMP_MIB_ITEM("MPJoinDisallowed",
> MPTCP_MIB_MPJOINDISALLOWED),
>  	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
>  	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
> MPTCP_MIB_JOINSYNTXCREATSKERR),
>  	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
> MPTCP_MIB_JOINSYNTXBINDERR),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 1ebdb55e9534..e97ee2d952a7 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -29,6 +29,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow
> context on ACK */
>  	MPTCP_MIB_JOINREJECTED,		/* The PM rejected
> the JOIN request */
>  	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on
> not-fully-established msk */
> +	MPTCP_MIB_MPJOINDISALLOWED,	/* RST JOIN early if
> disallowed: fallback/PM */
>  	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
> */
>  	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a
> socket when sending a SYN + MP_JOIN */
>  	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the
> address when sending a SYN + MP_JOIN */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b20258..f9785e20e209 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -117,7 +117,8 @@ static void subflow_req_create_thmac(struct
> mptcp_subflow_request_sock *subflow_
>  	subflow_req->thmac = get_unaligned_be64(hmac);
>  }
>  
> -static struct mptcp_sock *subflow_token_join_request(struct
> request_sock *req)
> +static struct mptcp_sock *subflow_token_join_request(struct
> request_sock *req,
> +						     u8 *reason)

We modified subflow_token_join_request() in this patch, but then
removed it in the next one, which seemed a little odd to me. I suggest
not removing this function - just changing its prototype would be
enough. For example:

static int subflow_token_join_request(struct request_sock *req,
                                      struct sk_buff *skb)

>  {
>  	struct mptcp_subflow_request_sock *subflow_req =
> mptcp_subflow_rsk(req);
>  	struct mptcp_sock *msk;
> @@ -126,12 +127,25 @@ static struct mptcp_sock
> *subflow_token_join_request(struct request_sock *req)
>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)),
> subflow_req->token);

We can set mptcp_token_get_sock() to "subflow_req->msk" instead of
"msk":

subflow_req->msk = mptcp_token_get_sock(sock_net(req_to_sk(req)),
	                                subflow_req->token);

>  	if (!msk) {

Then we can use subflow_req->msk to replace msk:

	if (!subflow_req->msk) {

>  		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
> +		*reason = MPTCP_RST_EMPTCP;

Set the skb reset_reason directly:

		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);

This requires declaring subflow_add_reset_reason at the beginning of
the file.

> +		return NULL;

No longer return "struct mptcp_sock *"; return an error code instead:

		return -EPERM;
> +	}
> +
> +	/* Stop it early if the subflow cannot be accepted.
> +	 * This check is inherently racy, the consistency safeguard
> is given by
> +	 * the fallback check at finish_join time.
> +	 */
> +	if (!mptcp_can_accept_new_subflow(msk)) {
> +		SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_MPJOINDISALLOWED);
> +		*reason = MPTCP_RST_EPROHIBIT;
> +		sock_put((struct sock *)msk);

sock_put is no longer needed here, because the msk reference is now
owned by subflow_req (set immediately) and will be released by the
destructor.

>  		return NULL;
>  	}
>  
>  	local_id = mptcp_pm_get_local_id(msk, (struct sock_common
> *)req);
>  	if (local_id < 0) {
>  		SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_MPJOINNOIDFOUND);
> +		*reason = MPTCP_RST_EMPTCP;
>  		sock_put((struct sock *)msk);
>  		return NULL;
>  	}
> @@ -252,17 +266,19 @@ static int subflow_check_req(struct
> request_sock *req,
>  			SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_TOKENFALLBACKINIT);
>  
>  	} else if (opt_mp_join && listener->request_mptcp) {
> +		u8 reason;
> +
>  		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
>  		subflow_req->mp_join = 1;
>  		subflow_req->backup = mp_opt.backup;
>  		subflow_req->remote_id = mp_opt.join_id;
>  		subflow_req->token = mp_opt.token;
>  		subflow_req->remote_nonce = mp_opt.nonce;
> -		subflow_req->msk = subflow_token_join_request(req);
> +		subflow_req->msk = subflow_token_join_request(req,
> &reason);
>  
>  		/* Can't fall back to TCP in this case. */
>  		if (!subflow_req->msk) {
> -			subflow_add_reset_reason(skb,
> MPTCP_RST_EMPTCP);
> +			subflow_add_reset_reason(skb, reason);
>  			return -EPERM;
>  		}

Then use subflow_token_join_request this way:

	if (subflow_token_join_request(req, skb))
		return -EPERM;

This way, in the next patch we only need to extract the two functions
subflow_check_req_mp_join() and subflow_check_req_mp_capable(), and
subflow_token_join_request() continues to be used in
subflow_check_req_mp_join().

WDYT? Attached is a squash-to patch with my changes.

>  
> @@ -280,15 +296,8 @@ static int subflow_check_req(struct request_sock
> *req,
>  
>  		subflow_req_create_thmac(subflow_req);
>  
> -		if (unlikely(req->syncookie)) {
> -			if
> (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
> -				SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_JOINREJECTED);
> -				subflow_add_reset_reason(skb,
> MPTCP_RST_EPROHIBIT);
> -				return -EPERM;
> -			}
> -
> +		if (unlikely(req->syncookie))
>  			subflow_init_req_cookie_join_save(subflow_re
> q, skb);
> -		}
>  
>  		pr_debug("token=%u, remote_nonce=%u msk=%p\n",
> subflow_req->token,
>  			 subflow_req->remote_nonce, subflow_req-
> >msk);
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b..308fad861afc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

Also, could the selftests part be put into a separate patch?

Thanks,
-Geliang

> @@ -78,6 +78,7 @@ unset join_ack_no_mpjoin
>  unset join_ack_no_ctx
>  unset join_not_established
>  unset join_no_id_found
> +unset join_disallowed
>  
>  unset rst_md5sig
>  unset rst_dss
> @@ -1595,6 +1596,7 @@ chk_join_nr()
>  	local ack_no_ctx=${join_ack_no_ctx:-0}
>  	local not_established=${join_not_established:-0}
>  	local no_id_found=${join_no_id_found:-0}
> +	local disallowed=${join_disallowed:-0}
>  	local rc=${KSFT_PASS}
>  	local count
>  	local with_cookie
> @@ -1617,10 +1619,21 @@ chk_join_nr()
>  	if [ -z "$count" ]; then
>  		rc=${KSFT_SKIP}
>  	elif [ "$count" != "$syn_ack_nr" ]; then
> +		# support old kernels without
> MPTcpExtMPJoinDisallowed counter:
> +		# => connections are rejected later on
> (MPTcpExtMPJoinRejected)
> +		if [ "${disallowed}" -gt 0 ] &&
> +		   ! mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinDisallowed" >/dev/null; then
> +			syn_rej=$((syn_rej + disallowed))
> +			syn_ack_nr=$((syn_ack_nr + disallowed))
> +		fi
> +
>  		# simult connections exceeding the limit with cookie
> enabled could go up to
>  		# synack validation as the conn limit can be
> enforced reliably only after
>  		# the subflow creation
> -		if [ "$with_cookie" != 2 ] || [ "$count" -le
> "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
> +		if [ "$count" != "$syn_ack_nr" ] && {
> +		     [ "$with_cookie" != 2 ] ||
> +		     [ "$count" -le "$syn_ack_nr" ] ||
> +		     [ "$count" -gt "$syn_nr" ]; }; then
>  			rc=${KSFT_FAIL}
>  			print_check "synack rx"
>  			fail_test "got $count JOIN[s] synack rx
> expected $syn_ack_nr"
> @@ -1658,9 +1671,18 @@ chk_join_nr()
>  	if [ -z "$count" ]; then
>  		: # ignore skip
>  	elif [ "$count" != "$syn_rej" ]; then
> -		rc=${KSFT_FAIL}
> -		print_check "syn rejected"
> -		fail_test "got $count JOIN[s] syn rejected expected
> $syn_rej"
> +		# support old kernels without
> MPTcpExtMPJoinDisallowed counter:
> +		# => with syncookies, the MPJoinRejected was
> incremented instead
> +		if [ "$with_cookie" = 2 ] && [ "${disallowed}" -gt 0
> ] &&
> +		   ! mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinDisallowed" >/dev/null; then
> +			syn_rej=$((syn_rej + disallowed))
> +		fi
> +
> +		if [ "$count" != "$syn_rej" ]; then
> +			rc=${KSFT_FAIL}
> +			print_check "syn rejected"
> +			fail_test "got $count JOIN[s] syn rejected
> expected $syn_rej"
> +		fi
>  	fi
>  
>  	# Per-event MPTCP_RST_EMPTCP JOIN counters; default 0, gated
> on
> @@ -1701,6 +1723,13 @@ chk_join_nr()
>  		fail_test "got $count JOIN[s] no id found expected
> $no_id_found"
>  	fi
>  
> +	count=$(mptcp_lib_get_counter ${ns1}
> "MPTcpExtMPJoinDisallowed")
> +	if [ -n "$count" ] && [ "$count" != "$disallowed" ]; then
> +		rc=${KSFT_FAIL}
> +		print_check "join disallowed"
> +		fail_test "got $count JOIN[s] disallowed expected
> $disallowed"
> +	fi
> +
>  	print_results "join Rx" ${rc}
>  
>  	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
> @@ -2180,8 +2209,8 @@ subflows_tests()
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> -			chk_join_nr 1 1 0
> +		join_disallowed=1 \
> +			chk_join_nr 1 0 0
>  	fi
>  
>  	# subflow
> @@ -2210,8 +2239,8 @@ subflows_tests()
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> -			chk_join_nr 2 2 1
> +		join_disallowed=1 \
> +			chk_join_nr 2 1 1
>  	fi
>  
>  	# single subflow, dev
> @@ -3546,7 +3575,7 @@ syncookies_tests()
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
>  		run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> +		join_disallowed=1 \
>  			chk_join_nr 2 1 1
>  	fi
>  
> @@ -4092,8 +4121,8 @@ userspace_tests()
>  		pm_nl_set_limits $ns2 1 1
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> -			chk_join_nr 1 1 0
> +		join_disallowed=1 \
> +			chk_join_nr 1 0 0
>  	fi
>  
>  	# userspace pm type does not send join
> @@ -4116,8 +4145,8 @@ userspace_tests()
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>  		sflags=backup speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
> -		join_syn_rej=1 \
> -			chk_join_nr 1 1 0
> +		join_disallowed=1 \
> +			chk_join_nr 1 0 0
>  		chk_prio_nr 0 0 0 0
>  	fi
>  

--=-KA/JCpe63bQv7Rj5DhFv
Content-Disposition: attachment;
	filename="0001-Squash-to-mptcp-subflow-split-subflow_check_req.patch"
Content-Type: text/x-patch;
	name="0001-Squash-to-mptcp-subflow-split-subflow_check_req.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBkOGM3NzkzYTllZWYxODk5ODdkOTNmOGUxZWY1MmM1ODQyNzU4ZTI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8ZDhjNzc5M2E5ZWVmMTg5OTg3ZDkzZjhlMWVmNTJj
NTg0Mjc1OGUyNy4xNzkzMzM0OTA1LmdpdC5nZWxpYW5nQGtlcm5lbC5vcmc+CkZyb206IEdlbGlh
bmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPgpEYXRlOiBGcmksIDMwIE9jdCAyMDI2IDEyOjM1
OjAxICswODAwClN1YmplY3Q6IFtQQVRDSF0gU3F1YXNoIHRvICJtcHRjcDogc3ViZmxvdzogc3Bs
aXQgc3ViZmxvd19jaGVja19yZXEoKSIKClNpZ25lZC1vZmYtYnk6IEdlbGlhbmcgVGFuZyA8Z2Vs
aWFuZ0BrZXJuZWwub3JnPgotLS0KIG5ldC9tcHRjcC9zdWJmbG93LmMgfCA3MSArKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvbXB0Y3Avc3Vi
Zmxvdy5jIGIvbmV0L21wdGNwL3N1YmZsb3cuYwppbmRleCAzMTM0ZmU4YWQ1NWIuLjgyMjZmYjFl
M2ZkZSAxMDA2NDQKLS0tIGEvbmV0L21wdGNwL3N1YmZsb3cuYworKysgYi9uZXQvbXB0Y3Avc3Vi
Zmxvdy5jCkBAIC0xMTcsNiArMTE3LDQ3IEBAIHN0YXRpYyB2b2lkIHN1YmZsb3dfcmVxX2NyZWF0
ZV90aG1hYyhzdHJ1Y3QgbXB0Y3Bfc3ViZmxvd19yZXF1ZXN0X3NvY2sgKnN1YmZsb3dfCiAJc3Vi
Zmxvd19yZXEtPnRobWFjID0gZ2V0X3VuYWxpZ25lZF9iZTY0KGhtYWMpOwogfQogCitzdGF0aWMg
dm9pZCBzdWJmbG93X2FkZF9yZXNldF9yZWFzb24oc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTggcmVh
c29uKTsKKworc3RhdGljIGludCBzdWJmbG93X3Rva2VuX2pvaW5fcmVxdWVzdChzdHJ1Y3QgcmVx
dWVzdF9zb2NrICpyZXEsCisJCQkJICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1
Y3QgbXB0Y3Bfc3ViZmxvd19yZXF1ZXN0X3NvY2sgKnN1YmZsb3dfcmVxID0gbXB0Y3Bfc3ViZmxv
d19yc2socmVxKTsKKwlpbnQgbG9jYWxfaWQ7CisKKwlzdWJmbG93X3JlcS0+bXNrID0gbXB0Y3Bf
dG9rZW5fZ2V0X3NvY2soc29ja19uZXQocmVxX3RvX3NrKHJlcSkpLAorCQkJCQkJc3ViZmxvd19y
ZXEtPnRva2VuKTsKKworCS8qIENhbid0IGZhbGwgYmFjayB0byBUQ1AgaW4gdGhpcyBjYXNlLiAq
LworCWlmICghc3ViZmxvd19yZXEtPm1zaykgeworCQlTVUJGTE9XX1JFUV9JTkNfU1RBVFMocmVx
LCBNUFRDUF9NSUJfSk9JTk5PVE9LRU4pOworCQlzdWJmbG93X2FkZF9yZXNldF9yZWFzb24oc2ti
LCBNUFRDUF9SU1RfRU1QVENQKTsKKwkJcmV0dXJuIC1FUEVSTTsKKwl9CisKKwkvKiBTdG9wIGl0
IGVhcmx5IGlmIHRoZSBzdWJmbG93IGNhbm5vdCBiZSBhY2NlcHRlZC4KKwkgKiBUaGlzIGNoZWNr
IGlzIGluaGVyZW50bHkgcmFjeSwgdGhlIGNvbnNpc3RlbmN5IHNhZmVndWFyZCBpcyBnaXZlbiBi
eQorCSAqIHRoZSBmYWxsYmFjayBjaGVjayBhdCBmaW5pc2hfam9pbiB0aW1lLgorCSAqLworCWlm
ICghbXB0Y3BfY2FuX2FjY2VwdF9uZXdfc3ViZmxvdyhzdWJmbG93X3JlcS0+bXNrKSkgeworCQlT
VUJGTE9XX1JFUV9JTkNfU1RBVFMocmVxLCBNUFRDUF9NSUJfTVBKT0lORElTQUxMT1dFRCk7CisJ
CXN1YmZsb3dfYWRkX3Jlc2V0X3JlYXNvbihza2IsIE1QVENQX1JTVF9FUFJPSElCSVQpOworCQly
ZXR1cm4gLUVQRVJNOworCX0KKworCWxvY2FsX2lkID0gbXB0Y3BfcG1fZ2V0X2xvY2FsX2lkKHN1
YmZsb3dfcmVxLT5tc2ssCisJCQkJCSAoc3RydWN0IHNvY2tfY29tbW9uICopcmVxKTsKKwlpZiAo
bG9jYWxfaWQgPCAwKSB7CisJCVNVQkZMT1dfUkVRX0lOQ19TVEFUUyhyZXEsIE1QVENQX01JQl9N
UEpPSU5OT0lERk9VTkQpOworCQlzdWJmbG93X2FkZF9yZXNldF9yZWFzb24oc2tiLCBNUFRDUF9S
U1RfRU1QVENQKTsKKwkJcmV0dXJuIC1FUEVSTTsKKwl9CisJc3ViZmxvd19yZXEtPmxvY2FsX2lk
ID0gbG9jYWxfaWQ7CisJc3ViZmxvd19yZXEtPnJlcXVlc3RfYmt1cCA9IG1wdGNwX3BtX2lzX2Jh
Y2t1cChzdWJmbG93X3JlcS0+bXNrLAorCQkJCQkJICAgICAgIChzdHJ1Y3Qgc29ja19jb21tb24g
KilyZXEpOworCXJldHVybiAwOworfQorCiBzdGF0aWMgdm9pZCBzdWJmbG93X2luaXRfcmVxKHN0
cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwgY29uc3Qgc3RydWN0IHNvY2sgKnNrX2xpc3RlbmVyKQog
ewogCXN0cnVjdCBtcHRjcF9zdWJmbG93X3JlcXVlc3Rfc29jayAqc3ViZmxvd19yZXEgPSBtcHRj
cF9zdWJmbG93X3JzayhyZXEpOwpAQCAtMTU3LDcgKzE5OCw2IEBAIHN0YXRpYyBpbnQgc3ViZmxv
d19jaGVja19yZXFfbXBfam9pbihzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsCiAJCQkJICAgICBz
dHJ1Y3QgbXB0Y3Bfb3B0aW9uc19yZWNlaXZlZCAqbXBfb3B0KQogewogCXN0cnVjdCBtcHRjcF9z
dWJmbG93X3JlcXVlc3Rfc29jayAqc3ViZmxvd19yZXEgPSBtcHRjcF9zdWJmbG93X3JzayhyZXEp
OwotCWludCBsb2NhbF9pZDsKIAogCXN1YmZsb3dfcmVxLT5zc25fb2Zmc2V0ID0gVENQX1NLQl9D
Qihza2IpLT5zZXE7CiAJc3ViZmxvd19yZXEtPm1wX2pvaW4gPSAxOwpAQCAtMTY1LDI2ICsyMDUs
OSBAQCBzdGF0aWMgaW50IHN1YmZsb3dfY2hlY2tfcmVxX21wX2pvaW4oc3RydWN0IHJlcXVlc3Rf
c29jayAqcmVxLAogCXN1YmZsb3dfcmVxLT5yZW1vdGVfaWQgPSBtcF9vcHQtPmpvaW5faWQ7CiAJ
c3ViZmxvd19yZXEtPnRva2VuID0gbXBfb3B0LT50b2tlbjsKIAlzdWJmbG93X3JlcS0+cmVtb3Rl
X25vbmNlID0gbXBfb3B0LT5ub25jZTsKLQkvKiBUaGUgbXNrIHJlZmNvdW50IHdpbGwgYmUgZGVj
cmVtZW50ZWQgaW4gc3ViZmxvd19yZXFfZGVzdHJ1Y3RvciAqLwotCXN1YmZsb3dfcmVxLT5tc2sg
PSBtcHRjcF90b2tlbl9nZXRfc29jayhzb2NrX25ldChyZXFfdG9fc2socmVxKSksCi0JCQkJCQlz
dWJmbG93X3JlcS0+dG9rZW4pOwogCi0JLyogQ2FuJ3QgZmFsbCBiYWNrIHRvIFRDUCBpbiB0aGlz
IGNhc2UuICovCi0JaWYgKCFzdWJmbG93X3JlcS0+bXNrKSB7Ci0JCVNVQkZMT1dfUkVRX0lOQ19T
VEFUUyhyZXEsIE1QVENQX01JQl9KT0lOTk9UT0tFTik7Ci0JCXN1YmZsb3dfYWRkX3Jlc2V0X3Jl
YXNvbihza2IsIE1QVENQX1JTVF9FTVBUQ1ApOworCWlmIChzdWJmbG93X3Rva2VuX2pvaW5fcmVx
dWVzdChyZXEsIHNrYikpCiAJCXJldHVybiAtRVBFUk07Ci0JfQotCi0JLyogU3RvcCBpdCBlYXJs
eSBpZiB0aGUgc3ViZmxvdyBjYW5ub3QgYmUgYWNjZXB0ZWQuCi0JICogVGhpcyBjaGVjayBpcyBp
bmhlcmVudGx5IHJhY3ksIHRoZSBjb25zaXN0ZW5jeSBzYWZlZ3VhcmQgaXMgZ2l2ZW4gYnkKLQkg
KiB0aGUgZmFsbGJhY2sgY2hlY2sgYXQgZmluaXNoX2pvaW4gdGltZS4KLQkgKi8KLQlpZiAoIW1w
dGNwX2Nhbl9hY2NlcHRfbmV3X3N1YmZsb3coc3ViZmxvd19yZXEtPm1zaykpIHsKLQkJU1VCRkxP
V19SRVFfSU5DX1NUQVRTKHJlcSwgTVBUQ1BfTUlCX01QSk9JTkRJU0FMTE9XRUQpOwotCQlzdWJm
bG93X2FkZF9yZXNldF9yZWFzb24oc2tiLCBNUFRDUF9SU1RfRVBST0hJQklUKTsKLQkJcmV0dXJu
IC1FUEVSTTsKLQl9CiAKIAlpZiAoc3ViZmxvd191c2VfZGlmZmVyZW50X3Nwb3J0KHN1YmZsb3df
cmVxLT5tc2ssIHNrX2xpc3RlbmVyKSkgewogCQlwcl9kZWJ1Zygic3luIGluZXRfc3BvcnQ9JWQg
JWRcbiIsCkBAIC0xOTgsMTYgKzIyMSw2IEBAIHN0YXRpYyBpbnQgc3ViZmxvd19jaGVja19yZXFf
bXBfam9pbihzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsCiAJCVNVQkZMT1dfUkVRX0lOQ19TVEFU
UyhyZXEsIE1QVENQX01JQl9KT0lOUE9SVFNZTlJYKTsKIAl9CiAKLQlsb2NhbF9pZCA9IG1wdGNw
X3BtX2dldF9sb2NhbF9pZChzdWJmbG93X3JlcS0+bXNrLAotCQkJCQkgKHN0cnVjdCBzb2NrX2Nv
bW1vbiAqKXJlcSk7Ci0JaWYgKGxvY2FsX2lkIDwgMCkgewotCQlTVUJGTE9XX1JFUV9JTkNfU1RB
VFMocmVxLCBNUFRDUF9NSUJfTVBKT0lOTk9JREZPVU5EKTsKLQkJc3ViZmxvd19hZGRfcmVzZXRf
cmVhc29uKHNrYiwgTVBUQ1BfUlNUX0VNUFRDUCk7Ci0JCXJldHVybiAtRVBFUk07Ci0JfQotCXN1
YmZsb3dfcmVxLT5sb2NhbF9pZCA9IGxvY2FsX2lkOwotCXN1YmZsb3dfcmVxLT5yZXF1ZXN0X2Jr
dXAgPSBtcHRjcF9wbV9pc19iYWNrdXAoc3ViZmxvd19yZXEtPm1zaywKLQkJCQkJCSAgICAgICAo
c3RydWN0IHNvY2tfY29tbW9uICopcmVxKTsKIAlzdWJmbG93X3JlcV9jcmVhdGVfdGhtYWMoc3Vi
Zmxvd19yZXEpOwogCiAJaWYgKHVubGlrZWx5KHJlcS0+c3luY29va2llKSkKLS0gCjIuNTUuMAoK



--=-KA/JCpe63bQv7Rj5DhFv--
