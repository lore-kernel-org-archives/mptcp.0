Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0551AEDF
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166950; cv=pass; b=ovVoYNr7N5nSJAHOFEa26inojg94gb8q9W2Ewe3LohPM+C1Yv/nLYR6cWff3z1URzRptJTXT0rwTO+COgwMDQM1uCBXQniHCWucJukyx4I2e0dDfYPylXww57PbrodjsuDRGscM87L4DeUPMNG5LlQiU9UpIz5pNqp9bfYV7bLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166950; c=relaxed/simple;
	bh=I2Bedx2EkyPrSaU6FA0d4z4cEFqzL9jSdyg6cGsmrQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPEgy574J6JFrk8cNH8OUhsAW8c0ldy4d3FG0XkvOlHTF2B2ZwoK1NCJMpSwBw85qyCkdoCFVm0pq9faqwvW75ccrMKOvwgFfuChCvTI2WlUt1sgDK+t76jmL1TJtfI+TtKfvYVkHtgDcUGSA70RtC3xBaYG1K6Ccu0MhlzNzH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaXOmhsJ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaXOmhsJ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso137873e87.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166944; cv=none;
        d=google.com; s=arc-20260327;
        b=MEMOJO044vIrmXPF13om13FeZ0XIcszOc3ExAU+zlSa5TrRFlr0HxDIXp4tUe0yBWd
         R7VpczKrSrPkrmRsPl3fRj7edf8jV7GzTfu078APArHKJVsKOxE8KS12PRo/TAk+Ujq6
         vqB2MjJTsBqam236x5J5n1cDZ7buvZrrq61EKdiJML3GTXciCbwgd3y3IHdpKHOMU4rr
         eN94GinYAWeHCYHmqPdo/EEMhvNuZoK2R5Ssoc/Kp2O1Mh5Be/564OSBcbR4wfhx5qr9
         X8ou9OBzuwLLWgAjepdy+EzfYmjgDTdcxozRbaCK6tN9U91EHjLaOrtZDqmRzD2wfl4k
         eVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0omMX9SBw6Tpu6sS3PIP5DnKU1/H2/7YeXKDruhKDSY=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=rIQVdkdz30kk6pfKr/8tbxnuIgXs1YN6DdtPlSb3nqaILk4fwIyhzzznh2Yr+dP+xt
         QK9Rs2UdFA10iMwu3NN66jM150wIEXuIqoGBxS/V+og5LsZmg5d1VaxZ6je+Pb/p02mO
         1jgwQSe57UmT7LChFN/YyQnoWd1jvDaTIvmZKJwhP6CeIrNojmWwg2vPn7bqVBHOBOXM
         G0y4z8VX69yxURjgBZ9Yo377aHGDV+Aw35n/GP2inGoZSyd2qjufPk4drEX7CI5RU5lN
         3XaghrdrRw4+5d2TWCkSZZ6iK2P83HmMzs4t7XAxevMxFe+Df68l/CN6rK3sjFLrNqSK
         UaQA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166944; x=1792771744; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0omMX9SBw6Tpu6sS3PIP5DnKU1/H2/7YeXKDruhKDSY=;
        b=aaXOmhsJ4CpuQD02vo2sMOZqH1sK9GgP1AaLcEbBC01104zEj7+JnQxWVU7PIREHAQ
         t2D674iTXQD9ymuTwKQp9sQX9se2lr1m7n4c7TpV7lN3F20u1CI9B/1EheirESmTlJLH
         6aTdPfX1F3qkkgWZqZtEnBKG7oqppeNEfoLhlMzr4d3UEa5OTaB1bvabQTt9Nnspjy0K
         k//oCpYQv6d/y8bgbj0qneJhZ+aCkp1XNNfkAh1fzKMrbolkm950JPwNwo0nLKdsH6Qp
         L0OxTkjkIkSLbhRL8TgdSQ72gWqM/X4ioFFBfLityWSJyxnKSGK/Y1H2lCeI6rsZGUvC
         6gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166944; x=1792771744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0omMX9SBw6Tpu6sS3PIP5DnKU1/H2/7YeXKDruhKDSY=;
        b=Vl+YTCNIrWpyZummX/Lh/VGaVmtm+pu9e9R/2ZbRLlxSt2kE8ESjdN5tV+BDvIYCVk
         7UPyZs/OJqjK5PyaEhN801zFq3exmNMhSKABMrHAxoO8KBBapMS4Z+FTyQiyvo0doJ3K
         yh5rQJoKrIXnzhetbRgBGcUNRzDB+qnL+YhiDGFx7ZssAAYuCwfBSq8ygCqOZLqX5wdy
         YXE08kZ8GY4b5EdHczj6wogVg5hQisl23dP7BkyBsDQJF0+4ShQEFqbm7l3utFsCO4/Z
         U4lDALfJrKkzyozO5qCMZ/mdCWC+HR7Xqk5XWmKP6kEUlSQGI9ag1uJc6r42/OxnEtDk
         3qAg==
X-Gm-Message-State: AFq9FYJpSdhBseWwIpSl8cTAAIv509tYq7bCHS6QQM3RS3Frhm4lzyxR
	yTrJJiCd5lDeSg4EUnWLtTOTPRoDquEJR/zsNHKI8QSmTzGHJiSRXMNYZjgA00/RtZF1a0s+sdm
	Vq0NNLsFXMcMCKh9vV0rlDejRjTJ2HIM=
X-Gm-Gg: AYBFou2j1YFkACX9BBE+TQ4BN9T2VX90QQye5O97ryZHqmg2JT4DPcxbke/va+PSnQZ
	5AzymrlKk/AgrEwJ9OoPNEHLlHvtdLWbcuVXDE/gUu53+cir+cOplArlU4/yM+LpXmkPnWEfGM7
	IF+9rSpnf/F18V6c2qu7k9C0IShz/KpQoleJnOEOWJ/PJ6DzOjoLpMchIP+dyhC29cpq6Eh7OVJ
	mEYq+G/pmx0h6Qg+bXuHsqngco5J1NVL8nMxeXJcskzareQGmaKx8Q1DxysF9q/rsXpTGKusHzZ
	0xs1uoLAMVIxMdvz22D7xCfGXuoe//3VW7MFLrRUz8V4AptfeFHUx5c=
X-Received: by 2002:a05:6512:3d8c:b0:5be:3eec:a966 with SMTP id
 2adb3069b0e04-5be50a46f37mr15421e87.13.1792166943637; Fri, 16 Oct 2026
 09:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
 <20261016055010.980819-4-anilkaushikwireless@gmail.com> <f084569d-5d99-4cd9-8513-26a21c9b2517@kernel.org>
In-Reply-To: <f084569d-5d99-4cd9-8513-26a21c9b2517@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Fri, 16 Oct 2026 21:38:52 +0530
X-Gm-Features: AclHuK_JdkQcykpG6q_wRoIwvXK8xVVi0KHAbzhhkrTDpwkHj0ugxomsDnDasPU
Message-ID: <CAG0Mgm8VvU39KfLpewh_Z=yuZte726_uT2bQ6_ucYFDvysjDzg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

 Thanks for the review!

On Fri, Oct 16, 2026 at 2:31=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> On 16/10/2026 07:50, Anil Kaushik wrote:
> > Test the subflow-retries limit, with its default value, and a long
> > connection in the background: drop the packets the client sends from
> > the additional subflow address with netfilter, without bringing the lin=
k
> > down, until the subflow is closed and re-created. Let them through agai=
n
> > later than tcp_syn_retries allows, and check the subflow comes back fro=
m
> > the same address. Then do the same with the initial subflow.
> >
> > Finally, close the connection while a subflow is being re-created, and
> > check the netlink events. The big files used for the long connection
> > are removed at the end.
> >
> > Assisted-by: LLM
> > Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> > ---
> >
> > Notes:
> >     v4:
> >      - default limit, no sysctl or MIB counter
> >      - more SYN retransmissions than tcp_syn_retries
> >      - close the connection while a subflow is re-created
> >      - check the netlink events
> >      - check the waits and the new subflow port, remove the big files a=
t
> >        the end (Sashiko)
> >     v3:
> >      - check the subflow address, create the files before the backgroun=
d job
> >     v2:
> >      - one test, with netfilter
> >
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 124 ++++++++++++++++++
> >  1 file changed, 124 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index f4d8afaeda4f..bbeff6739c5a 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -2151,6 +2151,69 @@ wait_attempt_fail()
> >       return 1
> >  }
> >
> > +# $1: ns ; $2: counter ; $3: expected minimum value
> > +wait_counter()
> > +{
> > +     local cnt
> > +
> > +     for _ in $(seq $((timeout_poll * 10))); do
> > +             cnt=3D$(mptcp_lib_get_counter "${1}" "${2}")
> > +             [ "${cnt:-0}" -ge "${3}" ] && return 0
> > +             sleep 0.1
> > +     done
> > +
> > +     return 1
> > +}
> > +
> > +# $1: client address ; prints the local address and port of its subflo=
w
> > +sf_from()
> > +{
> > +     ip netns exec $ns2 ss -tnH state established src "${1}" |
> > +             awk '{ print $3; exit }'
> > +}
> > +
> > +# $1: client address to block
> > +#
> > +# The link stays up, but the client packets from this address are drop=
ped:
> > +# the subflow using it is closed after a few retransmissions, and re-c=
reated.
> > +# The packets go through again later than tcp_syn_retries allows: the =
new
> > +# subflow still connects thanks to the subflow-retries limit.
> > +sf_retry_after_block()
> > +{
> > +     local syn_tx ack_rx before after
> > +
> > +     syn_tx=3D$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
> > +     ack_rx=3D$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
> > +     before=3D$(sf_from "${1}")
> > +
> > +     print_check "subflow from ${1}"
> > +     if [ -z "${before}" ]; then
> > +             fail_test "no established subflow from ${1} before the bl=
ock"
> > +             return
> > +     fi
> > +
> > +     ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" =
drop
> > +     if ! wait_counter $ns2 "MPTcpExtMPJoinSynTx" $((${syn_tx:-0} + 1)=
); then
> > +             ip netns exec $ns2 nft flush chain ip filter OUTPUT
> > +             fail_test "subflow from ${1} not re-created"
> > +             return
> > +     fi
> > +     sleep 5
>
> Do you need a long sleep here?
It was there to show the new subflow outlives tcp_syn_retries. In v5,
the test waits for the SYN retransmissions instead, with
tcp_syn_linear_timeouts=3D0, so no sleep.

>
> We usually try to have "quick" tests. Here it looks like we do nothing
> for 5 seconds, and possibly the sleep is not even needed.
>
> > +     ip netns exec $ns2 nft flush chain ip filter OUTPUT
> > +
> > +     if ! wait_counter $ns1 "MPTcpExtMPJoinAckRx" $((${ack_rx:-0} + 1)=
); then
> > +             fail_test "re-created subflow from ${1} not established"
> > +             return
> > +     fi
> > +
> > +     after=3D$(sf_from "${1}")
> > +     if [ -z "${after}" ] || [ "${after}" =3D "${before}" ]; then
> > +             fail_test "no new subflow from ${1}: ${before} -> ${after=
}"
> > +     else
> > +             print_ok
> > +     fi
> > +}
> > +
> >  set_userspace_pm()
> >  {
> >       local ns=3D$1
> > @@ -2585,6 +2648,67 @@ link_failure_tests()
> >               chk_stale_nr $ns2 1 -1 2
> >               chk_link_usage $ns2 ns2eth3 $cinsent 50
> >       fi
> > +
> > +     # subflows closed after a silent link failure, then re-created: t=
he
> > +     # additional one, then the initial one. Then close the connection
> > +     # while a subflow is being re-created.
> > +     if reset_with_events "subflow retry after link failure" &&
> > +        continue_if mptcp_lib_kallsyms_has "mptcp_pm_kernel_retry$"; t=
hen
>
> Probably best to check if the new limit exists: modifying pm_nl_ctl (in
> a dedicated commit) and see if it is there. Maybe pm_netlink.sh will
> need to be modified as well.
>
> (And iproute2 too if you don't mind, please :) )
Sure, I will send it after this series.
>
> > +             init_nftables
> > +             init_shapers
> > +             ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3D3
> > +             ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=3D1
> > +             ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=3D5
> > +             pm_nl_set_limits $ns1 0 4
> > +             pm_nl_set_limits $ns2 0 2
> > +             pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflo=
w
> > +             # created here, not in the background job, for cleanup()
> > +             if [ -z "$cinfail" ]; then
> > +                     cinfail=3D$(mktemp)
> > +             fi
> > +             if [ -z "$sinfail" ]; then
> > +                     sinfail=3D$(mktemp)
> > +             fi
> > +             { timeout_test=3D120 test_linkfail=3D131072 \
> > +                     run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> > +             local tests_pid=3D$!
> > +
> > +             wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1
> > +             sf_retry_after_block 10.0.3.2
> > +             sf_retry_after_block 10.0.1.2
> > +
> > +             ip netns exec $ns2 nft add rule ip filter OUTPUT \
> > +                     ip saddr 10.0.3.2 drop
> > +             wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4
> > +             local retrying=3D$?
> > +             mptcp_lib_kill_group_wait $tests_pid
> > +
> > +             # stopped at the latest by the close timeout
> > +             print_check "no subflow connecting after close"
> > +             for _ in $(seq $((timeout_poll * 10))); do
> > +                     ip netns exec $ns2 ss -tnH state syn-sent | grep =
-q . ||
> > +                             break
> > +                     sleep 0.1
> > +             done
> > +             if [ "${retrying}" -ne 0 ]; then
> > +                     fail_test "no subflow re-created before the close=
"
> > +             elif ip netns exec $ns2 ss -tnH state syn-sent | grep -q =
.; then
> > +                     fail_test "subflow still connecting after close"
> > +             else
> > +                     print_ok
> > +             fi
>
> Best to move this block from print_check in a new helper: we usually
> avoid adding "subchecks" in tests directly.
>
> > +             ip netns exec $ns2 nft flush chain ip filter OUTPUT
> > +             kill_events_pids
> > +
> > +             join_syn_tx=3D4 chk_join_nr 3 3 3
> > +             chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> > +             chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
> > +
> > +             # big files: do not keep them, the next tests create thei=
r own
> > +             rm -f "$cinfail" "$sinfail"
> > +             cinfail=3D""
> > +             sinfail=3D""
> > +     fi
> >  }
> >
> >  add_addr_timeout_tests()
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Regards
Anil
