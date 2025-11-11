Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656342BE05E
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841649; cv=none; b=IvWGNNU9yIvXy7LeLb+B+QrPYGdGINWBq1DeZGZtclu7/trXfLZef5tIWBnsh15oJZs100dePL2ssY+dT1LKtkw2F424KsP9wSL4ODGsgUtBDUQyCev80lCseJtLU4ABxcXZPYgd3FdXXGf5ZGOOmzBfmCESTbCitP1a73rvby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841649; c=relaxed/simple;
	bh=zpxo7RrXRhhKqGtKgD8L6ilIbKbR0IwxFObP7FPz+bQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SeJL391OReJ8JZFvkFVegQ4Q0fqgDO8Oy/9Bnq5dJ1fOC7MsY0Iq9yy991aAeEe9C7Gx/NUE3eDAm7LkvZTbo0B9vedDGjjX0l/uFRsuqy7RGVs/nUO4Ip8BFsQ6KNC3Jgy0qamDIqGZpYXCsjQag6JAgOJEyiv0wlO7+FziMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq/PM5pS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq/PM5pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4E7C19421;
	Tue, 11 Nov 2025 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762841649;
	bh=zpxo7RrXRhhKqGtKgD8L6ilIbKbR0IwxFObP7FPz+bQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Uq/PM5pSNOKXhR0LuX6tAEIb6yxCeTOP5L5PqvIZ0YlDNRMO+surACRVESNkapxg2
	 prr/6Xsom1ljJn1aVH2HjTb+6rZQotcFO/h7uas4yoUQdf6KZkqDsc+7GyKBtn5c2t
	 1VtRXy7dEwt/pA4a16gEYki7fUsdT0EmS1T4w/jqL0TMJP24pBsJbYViS5GaupmydF
	 Nnj/oXqfAbmlNsoPFrhTg1KTAC6gTx6dwAwotPoGxzpbh+fjFYQ5Un3T/I8gtW+ZDb
	 CLTAh9l5wm2pv2RYQWpnvqOv1vRzGibw0LtmwO2bStWI+/p2D/m4StJkzk13R9nIsY
	 Jg7j2i/Cm+4cw==
Date: Tue, 11 Nov 2025 07:14:04 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Message-ID: <be209b04-d721-4f75-a05c-56899eb2942f@kernel.org>
In-Reply-To: <5a0c227a3a2b660492af391af65eaae8afe31ad0.camel@kernel.org>
References: <cover.1762500073.git.pabeni@redhat.com> <32586f43554a4837f39d534676c5ad957dc10dd5.1762500073.git.pabeni@redhat.com> <5a0c227a3a2b660492af391af65eaae8afe31ad0.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix duplicate reset on
 fastclose
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <be209b04-d721-4f75-a05c-56899eb2942f@kernel.org>

Hi Geliang,

11 Nov 2025 02:59:28 Geliang Tang <geliang@kernel.org>:

> Hi Paolo,
>
> Thanks for this v2.
>
> On Fri, 2025-11-07 at 08:23 +0100, Paolo Abeni wrote:
>> The CI reports sporadic failures of the fastclose self-tests. The
>> root
>> cause is a duplicate reset, not carrying the relevant MPTCP option.
>> In the failing scenario the bad reset is received by the peer before
>> the fastclose one, preventing the reception of the latter.
>>
>> Indeed there is window of opportunity at fastclose time for the
>> following
>> race:
>>
>> mptcp_do_fastclose
>> =C2=A0 __mptcp_close_ssk
>> =C2=A0=C2=A0=C2=A0 __tcp_close()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_set_state() [1]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_send_active_reset() [2]
>>
>> After [1] the stack will send reset to in-flight data reaching the
>> now
>> closed port. Such reset may race with [2].
>>
>> Address the issue explicitly sending a single reset on fastclose
>> before
>> explicitly moving the subflow to close status.
>>
>> Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios");
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>> =C2=A0- test subflow->send_fastclose in __mptcp_subflow_disconnect()
>> instead
>> =C2=A0=C2=A0 of MPTCP_CF_FASTCLOSE
>> ---
>> =C2=A0net/mptcp/protocol.c | 37 +++++++++++++++++++++++--------------
>> =C2=A01 file changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0301e0b0de05..24d4fa8227b7 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2437,7 +2437,6 @@ bool __mptcp_retransmit_pending_data(struct
>> sock *sk)
>> =C2=A0
>> =C2=A0/* flags for __mptcp_close_ssk() */
>> =C2=A0#define MPTCP_CF_PUSH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1)
>> -#define MPTCP_CF_FASTCLOSE BIT(2)
>> =C2=A0
>> =C2=A0/* be sure to send a reset only if the caller asked for it, also
>> =C2=A0 * clean completely the subflow status when the subflow reaches
>> @@ -2448,7 +2447,7 @@ static void __mptcp_subflow_disconnect(struct
>> sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flags)
>
> nit:
>
> The 3rd argument "flags" of __mptcp_subflow_disconnect is useless now.
> We can drop it.

I don't think it is useless: __mptcp_close_ssk() is still called with eithe=
r
the push flag or no flag (0).

Because this patch is for net, we should avoid unnecessary modifications:
we should not change the type or the name of the function argument for
"cosmetic" reasons.

>
> No need to send v3, Matt or I can handle it.
>
> Thanks,
> -Geliang
>
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0 if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN=
)) ||
>> -=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (flags & MPTCP_CF_FASTCLOSE)) {
>> +=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 subflow->send_fastclose) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The MPTCP code never wait =
on the subflow sockets,
>> TCP-level
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * disconnect should nev=
er fail
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> @@ -2511,20 +2510,13 @@ static void __mptcp_close_ssk(struct sock
>> *sk, struct sock *ssk,
>> =C2=A0=C2=A0=C2=A0 if (dispose_it)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&subflow->node);
>> =C2=A0
>> -=C2=A0=C2=A0 if ((flags & MPTCP_CF_FASTCLOSE) &&
>> !__mptcp_check_fallback(msk)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* be sure to force the tcp_close =
path
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to generate the egress res=
et
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk_lingertime =3D 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_set_flag(ssk, SOCK_LINGER);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subflow->send_fastclose =3D 1;
>> -=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0 if (subflow->send_fastclose && ssk->sk_state !=3D TCP_CLOS=
E)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_set_state(ssk, TCP_CLOSE);
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0 need_push =3D (flags & MPTCP_CF_PUSH) &&
>> __mptcp_retransmit_pending_data(sk);
>> =C2=A0=C2=A0=C2=A0 if (!dispose_it) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_subflow_disconnect(ss=
k, subflow, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_sock(ssk);
>> -

(This line should not be removed but this can be fixed when applying the pa=
tch.)

Cheers,
Matt
