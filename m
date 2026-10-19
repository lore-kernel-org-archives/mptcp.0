Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792433235;
	b=HYVF6rR+kF8hv5cOf4eVv7Tv8Dwd/OKHcK6TrK8sSH6iu5nx/PePZeT4xU62gmAtmnJf
	 9MXE7kHNvOzJMj26uWLvJvVLfml2CNCQj458IlGZm+zMeNARgKjNuispItEpBZUs8prn0
	 SuoENLvI6VLKgBOu9WLwXh4ib1703TQ7pwFVhx95yyqVLxPfzB+D3BASDtkIuHmFun8gs
	 KUuHXbKlDnnPaBnqPFAmPmNp29kSbDcQYdh/Fx1nx3rvZxKOiFyDkjI8qvybbGdc1IhA3
	 GkXOoED7uJdo+7N6coZYwBM0bIUz1EyNgi2ta8NTNz7HiibcyDIdQ645n0HpsDBAGOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DEJV8xQlL0xVkyf8dK6PmApV2yQEU9Zhc1SWw8MItB4=;
	b=ghrwPIewm6jRm0/ZnNtuAO7DmE/nDWM8KXbDE+Iy8TS4noDq4LoeHu5xReBfcjqrQwe6
	 JomSdcQoZS5DKnAhSrviAwksXzrhP0LmlK3w9FQNGJvTIvsxABoq0QOkdmi9LAIResi2R
	 4JzHwHv9xczYTL8XsIZD/7LhDFUtzW0FfBV/JRkp7e3oD2a8WxL3taWNMPnozYIjM1Ex4
	 t5EGOdm54UmUs6VgVyFE+Cc/eg+n5Mmc64jKQlKPL3eg43bvJkxfb34fbDjmn2tisSjyP
	 GjETjUGeQUFkvAcV7/fPI9qQPacUrOu0B0N9TnfuGE4vQIiWxaKrpG2RCOOP7/+XBPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLMvvL3t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA00606A31B
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA00606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DLMvvL3t
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso2424854e87.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792433233; cv=none;
        d=google.com; s=arc-20260327;
        b=IarEZxj9CPJtF9Ml0Lz8QTMza/24Gs9xyxvF2PaqltoeL0hHJDN0odAQcDvWIEZtdl
         oPfS8orEU2BbngOhKufUP7ODpSOurXDsAFW3wnq+U+XdQfMqq5rd0nHjSWq3m/BfSUP6
         Im51ujWq7BdigMyrEiE0oFj9I07bYjaeHeB/EoRzV83XEnpwgGczDiHd2N50UPIokHpl
         ymcIgZY01T91Mtg/6BTVaIDHzD8xyazNET6N+lWvq1u97ln09VarowJDQkNvemh47IAd
         goGI8xSJgrsB67BE9a5j2q/HCWItKeayeXtn6XVSkbi4lzjGmV7s/6S8c94MdtmssyCp
         q9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DEJV8xQlL0xVkyf8dK6PmApV2yQEU9Zhc1SWw8MItB4=;
        fh=qbu6ELIPq5lPEfhFTFjzONzOizYMCuLEdDhIgMexi2Q=;
        b=WU1zu2GwUV8Im8KMoewIsCVsXsDbGBrAArUpw3gLV7uAwyP5RJ0j4TXILk6giVpiTh
         zVm0TQc8uhQgHzGKNsoGFIqVc82Iolwx4XzglDDgrXTNFVkvatNbEzFiLzaPZcO/yhFr
         PVKS4cX/wwuGBkN8Gse54gd3xLxliOC5hC/o+7wH/a83fC4fpP63+96PeO9AuP2k05/v
         D/cN/TdofbM4SQ9q1xQ6W7kSeL4VmfB86qFDDMQvT8N6IFMelLFBl4ScTKpVqDcaK811
         oiBZvu9NvLy+EjNNM3AJ2dPadFva0TlMgBlnKneunZaNJ8pLnW076FaH1LxxxWQ35wgs
         QXpw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792433233; x=1793038033; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DEJV8xQlL0xVkyf8dK6PmApV2yQEU9Zhc1SWw8MItB4=;
        b=DLMvvL3tq/Rf3tnYcq5soW0eS1+EAzVFYQOT3DiuBZ8edsbkkq6Y9eaBLhAoZ2kDEx
         ORZl5TzC5O83yGT98cbn6tNff8aVNLx7BYdg2F5uSfasauWvMG8I7EuR9ax2I154c6Tt
         XMClpAMm5ny/SpIXlP8+NUsNGDk4TwXbP+jRSerGnGrOdVPlQwIcMbyIYVgEvOQQuB19
         bw9uFR59BJNgA0ZLNjdtrcplxMeFODixo7FtR486jhi3B/e7cafKHppn9V6qnWSx04MZ
         gBF7RiJwqJELF8yUNOH6NpXYYKmI8XZwSUEGnNiLA6jQS4Q6Sh+ZIOTG1S8G4ood24GC
         BWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792433233; x=1793038033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DEJV8xQlL0xVkyf8dK6PmApV2yQEU9Zhc1SWw8MItB4=;
        b=CzdVPq5JEoGlykQwvkfZ87F2hdVqW6fY8s+a4vkEv6Er4zltklBj5orh7MVwMkhdiT
         lJmZK66gaKdWOcgBaWHivDRAZilqgntwKkTR3j3SR/WqH8zGdmCC5nZUpu/JyrYJaQTd
         0uureeCtM3b4HbL7Cp4m5F0EMys8g67LO7pYdWp+aZGU05iFhxDIxZdFFFop1fi4qTzj
         5ht6wDWYPawccsybUf1LvQ5YAMUp0sKjMhaDNTa9E4sa6/4gb90mOmaOYS+OfhENkyKe
         xHlVgthIPQpga6gQ9DiXaASXDdp1TWp7Rs3/1xMXkWztA3o2QZ6DABvs1Y+Cn32hJXSv
         CvGw==
X-Gm-Message-State: AFq9FYIUMomZdkA0/I4oqNgzHopoa96Wj5njO+hOy4RuecP2zkgTLiT4
	4wE5fdt+YDU3xowpmHjU9syGengmUDOExcW9US65z6PGDo0I7GcwTd3J5oQCwk7rrtP17LQ5P57
	nr9+2MgDH9Ea5PUDIsuh1IWziBIJuu11w4WIU
X-Gm-Gg: AYBFou1EVEUTAGpzB/2aO3LFEhR2TyYAK9TCOx51+MQ0BPsWylt9hAeNhYwm6f3mal5
	nxIZcgHgzJ1gtszJ56vxHG3AUH2wC0HTFX2orHEidNqyuoK99XQLES2bjpMEce2nzadGn11pOhE
	MmS/SCwRtJqMDnk7aLt9zQNGNxO8FT1XZYXT0sQELkD1cEHt4aH5zeFRqSyra/G/w50N4gwhrTf
	jHEMoTCB+xlGAciUZWnZm/0c42p+kgR2T0C0xLRTF/tWUtcz/hAjFNbv513yyMruZuma/QPZXMg
	bJhinhReFWYGZP+63RpA397L7/b4SBM1y6Uefkfd7xXpGgJ5Dktl3Wk=
X-Received: by 2002:a05:6512:39c6:b0:5b8:e99c:cfa1 with SMTP id
 2adb3069b0e04-5be50a595a4mr2845160e87.31.1792433233122; Mon, 19 Oct 2026
 11:07:13 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261018041748.1655711-7-anilkaushikwireless@gmail.com> <179243197932.3133.1635647280837164563@kernel.org>
In-Reply-To: <179243197932.3133.1635647280837164563@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Mon, 19 Oct 2026 23:37:01 +0530
X-Gm-Features: AclHuK-Y0jBIXFomSuesjT3LnSZRA2OWNPFkAluxDK1PksNCvC80sXu6_KSHqfM
Message-ID: <CAG0Mgm9dWLhLPGGQrUv6qHone3U1k_iikFTp+yNG=KRQz-jCsw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v6 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, all four are valid, they will be fixed in v7.

Regards
Anil

On Mon, Oct 19, 2026 at 11:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In link_failure_tests(), the new "subflow retry after link
>   failure" block empties the shared input files at the end (`: >=E2=80=A6
> - [Low] In sf_retry_after_block(), the drop rule is flushed (`ip netns
>   exec $ns2 nft flush chain ip filter OUTPUT`, line 2225) before=E2=80=A6
> - [Low] sf_retry_after_block() decides whether the subflow was re-created
>   by comparing the local address:port strings from `ss` before and after=
=E2=80=A6
>
> --
>
> selftests: mptcp: join: validate subflow retry after link failure
>
> This adds a test to link_failure_tests(). It uses nftables to drop the
> client packets from one subflow address until the subflow is closed and
> re-created, and lets them through again once the new SYN has been
> retransmitted more times than tcp_syn_retries allows. This is done for
> the additional subflow and then the initial one. The test then closes
> the connection while a subflow is being re-created, checks the netlink
> events, and empties the big input files at the end.
>
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index f4d8afaeda4f3..d4b4146cbd64b 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -2151,6 +2151,111 @@ wait_attempt_fail()
> >       return 1
> >  }
> >
> > +# $1: timeout in seconds ; $2: ns ; $3: counter ; $4: increment, 1 by =
default
> > +wait_counter_inc()
> > +{
> > +     slowwait_for_counter "${1}" "${4:-1}" \
> > +             mptcp_lib_get_counter "${2}" "${3}" >/dev/null
> > +}
>
> [ ... ]
>
> > +sf_retry_after_block()
> > +{
> > +     local before after
> > +
> > +     before=3D$(sf_from "${1}")
>
> [ ... ]
>
> > +     # tcp_syn_retries=3D1: one more retransmission than allowed
> > +     if ! wait_counter_inc "${timeout_poll}" \
> > +             $ns2 "TcpExtTCPSynRetrans" 2; then
> > +             ip netns exec $ns2 nft flush chain ip filter OUTPUT
> > +             fail_test "SYN from ${1} not retransmitted enough"
> > +             return
> > +     fi
> > +     ip netns exec $ns2 nft flush chain ip filter OUTPUT
> > +
> > +     if ! wait_counter_inc "${timeout_poll}" $ns1 "MPTcpExtMPJoinAckRx=
"; then
>
> [Severity: Low]
> Can this wait miss the MP_JOIN ACK it is waiting for?
>
> The drop rule is flushed before wait_counter_inc() reads its baseline.
> slowwait_for_counter() in net/lib.sh only reads the baseline when it is
> called:
>
> tools/testing/selftests/net/lib.sh:slowwait_for_counter() {
>         ...
>         local base=3D$("$@")
>         slowwait "$timeout" until_counter_is ">=3D $((base + delta))" "$@=
"
> }
>
> The re-created subflow keeps retransmitting its SYN on its own timer
> (mptcp_pm_kernel_retry() sets icsk_syn_retries). If a retransmission
> lands between the nft flush and the nstat read, the handshake can finish
> and MPTcpExtMPJoinAckRx can go up before the baseline is taken.
>
> The wait would then need one more MP_JOIN ACK that never arrives. It
> would time out after timeout_poll and report "re-created subflow from
> ... not established", even though the subflow came back.
>
> With exponential backoff, the next retransmission is about 4 seconds
> away, so this only happens if the script stalls. Would it still be
> more robust to read the counter before the flush and poll against that
> saved value?
>
> > +             fail_test "re-created subflow from ${1} not established"
> > +             return
> > +     fi
> > +
> > +     after=3D$(sf_from "${1}")
> > +     if [ -z "${after}" ] || [ "${after}" =3D "${before}" ]; then
> > +             fail_test "no new subflow from ${1}: ${before} -> ${after=
}"
>
> [Severity: Low]
> Is the address:port string always different for a re-created subflow?
>
> The retry binds with port 0:
>
> net/mptcp/pm_kernel.c:mptcp_pm_kernel_retry_check() {
>         ...
>         retry->local.addr.port =3D 0;
>         ...
> }
>
> __mptcp_subflow_connect() then passes this address to kernel_bind(), so
> the kernel picks an ephemeral port. The old subflow was also bound with
> port 0. It released its port when it reached TCP_CLOSE, and the retry
> check runs at that point, so the allocator can hand out the same port
> again.
>
> If that happens, this reports "no new subflow from 10.0.3.2: X -> X",
> even though the MPJoinSynTx, TCPSynRetrans and MPJoinAckRx waits above
> have already shown that a new subflow was established.
>
> The odds are low, roughly 1 in 14000 per run for the 10.0.3.2 case.
> Could the check rely on the MPJoinAckRx wait and an established subflow
> being present, instead of comparing ports?
>
> [ ... ]
>
> > @@ -2585,6 +2690,65 @@ link_failure_tests()
>
> [ ... ]
>
> > +             join_syn_tx=3D4 chk_join_nr 3 3 3
> > +             chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> > +             chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
> > +
> > +             # big files: empty them, the next tests write their own c=
ontent
> > +             : > "$cinfail"
> > +             : > "$sinfail"
> > +             : > "$cinsent"
>
> [Severity: Medium]
> Does the comment "the next tests write their own content" hold for the
> test_linkfail=3D1 and test_linkfail=3D2 callers?
>
> The files are emptied, but cinfail and sinfail still hold their paths.
> For those modes, run_tests() only fills the files when the variable is
> empty:
>
> tools/testing/selftests/net/mptcp/mptcp_join.sh:run_tests() {
>         ...
>         elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
>         ...
>         elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
>         ...
> }
>
> Only the test_linkfail > 2 branches always rewrite the files.
>
> The default order isn't affected, because this block is the last one in
> link_failure_tests(). However, the getopts loop adds one entry per
> option and doesn't remove duplicates:
>
>         tests+=3D("${all_tests[${opt}]}")
>
> So "mptcp_join.sh -l -l" runs link_failure_tests() twice. On the second
> run, the test_linkfail=3D1/2 subtests would send 0-byte files and leave
> $cinsent empty. chk_stale_nr() would then fail, and chk_link_usage()
> would divide by zero:
>
>         local tx_rate=3D$((tx_link * 100 / tx_total))
>
> Reordering the groups, or adding a test_linkfail=3D1/2 case after this
> one, would cause the same failures. Would it be better to remove the
> files and reset cinfail and sinfail, or to have those branches check
> [ ! -s "$cinfail" ] instead?
>
> > +     fi
> >  }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261018041748.1655711-1-anilkaushikwireless%40gmail.com
