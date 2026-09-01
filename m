Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F5380FFD
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252764; cv=none; b=RT90HhdUD1wS1RgCBShfI/CKR1ltAeUf7XdAEfYdm7Oetn4tefyjPCtH2JMOaDQ6tWxSM6uAzGeQmMuF9e8UafZD9MlzL+O81ZebFHDtpKfEuyLCG5N/CQDg9bJdivjNG5b3GSO+mfesq311p7x8Fvsh+QR93RSrHeAyCKBLSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252764; c=relaxed/simple;
	bh=vqDdqg3IBdL9Dx8Ej2w1ihrvqYDKoRmLu6NhMTnI0vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=u3MTAeRA03nj6Bi6nuaD58/vFKitX2wFYeLrFlrcRDv6s6HpZ+eneR22r9Auo2fM6CTrSkjEvklM2vMuh65rkUS9vrnFKI/0c6wnreMd8WWnNcEkJP/w7EWFfib49Zk4NF5O62kZfXhzzmYPbor7zT2CpkcEeLvVrupkyDNOTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB5vVfhn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB5vVfhn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed3993c1eso43407385a.1
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788252762; x=1788857562; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MmxV1N+yhGz6HNdztWx7LrtY764zSoadiDcdBuw0wIo=;
        b=AB5vVfhnh71vpV/Hx5zrJbpyfWyrF9MgahQp/6W2xSK3f1bFqnDEgOBB1S30EhuRzf
         ari2jRf4J7QpJ61EupiXAhfYukpWFOMP73PLiEVltwWI/ABmM5wkCjOadEZ5Y2P52Mlg
         GR1ozYUoeU0Ef1S1b+X0966ergY+sd3+EjkVP5FMtbdC64GgXfBrmxY7t5QXLI7urLC0
         XTc9cDdmcDXVfB2b5GY5VZaCboD3opRCLI5Ee9AMr2petEmfyv3HhZbAj9i4eWIizj+L
         Fbqi50/NxJcRHXnVXz/JBaHBy3djDRpUuw4szM0UfX0GGAcn7Y0ZeSJPHJ5i1aX++2Y8
         SvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788252762; x=1788857562;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmxV1N+yhGz6HNdztWx7LrtY764zSoadiDcdBuw0wIo=;
        b=VpOKGcU6CvrdrWjG64DD9c73j7xN8qnjjxXjMChfmITHHsZdbUPf4Y5LPnBmgK/Jdy
         SyEnFyzvwgBNQdXCFYuxptdiGO8DHACqbRn0WGe6C02CZJudM7Mn/Ar9jjGi/zxTZQkN
         L2Uwzjy0RVq2/loNBJIj3cUjRj7QcFbgMBtK17eKCzymmxUFU+Jjtt60ru14QfbU5lnc
         bZeBcT8wZOiVIGml6/u5OGlxwwfj84Dtd7PvVSGXS/d0SKpu5MmFS3aktX7sfIXP8lj1
         SjYt30Ei0gMNgYGZpwbEGIADV2nGAKMST5+goQHvQK83rkSjN3itZm6L9jfuM83PIpGd
         +01A==
X-Gm-Message-State: AFuF++nO6x88yMv53cNHNt7Sn44vWfVPoaBwFigoXHWrdZVdDC/nEQwB
	pgxptEyR8sGqGqjNMTBJnVUxnjo87IWE2ewCAHlHuBGHddGY9DlXxXh+u6Vx
X-Gm-Gg: AR+sD131+imMqsJzwJi36jTTTL6+zeFFq1TReZxP/azsm1f22kbRXEN7PlF2mbumOsb
	GqSWFNmLIy+XxD7wdwbAqhjaSNWJL2t7HSUBbweWI/E4eiy6AO4R0j3SpsxjypjolatmjpuFVQ4
	q/XHguDMf1o6Aj0V/JteE3RAyphw14xNfWWqd5EhzrK9mneJ8Kvayc+z533xS3s7WsuvFD2EvLk
	xLY+UKHVFs03ckDC4vQcewrMJYI9vNwDFBb3esPtSNoL9hTHmeLAAqlKRRxWZ8zW51ThUDE86B+
	woFiLWfS8Bxs8hj3r8TCIXwodAXRQN2v57sKGdtF545W9X4KQnwG6gX573N+CjaVEbhJJwSLX6S
	0El2y/jqMXdDfQ72/pmlkUwcUgoiY8UNc/gnYsmGWwtCaiYVW797OF/c5w4GlqefkHhkji77rKw
	T5fk3Esg7g+Mv6czJW8AcnuUfq6Of3wvJmy22GdDETZ/J/jyQ145ViaQLToliUcgyFhbdTpnu/E
	w==
X-Received: by 2002:a05:620a:400b:b0:939:4890:98f6 with SMTP id af79cd13be357-9394890ae71mr788652785a.22.1788252761860;
        Tue, 01 Sep 2026 01:52:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.239.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391700a637sm982081585a.5.2026.09.01.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:52:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn>
References:
 <70a7e7e05337faa0547c3759e5d9829763f2bcc5.1788244452.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: fix skb_ext leak in fallback mode
Message-ID: <36c4f6ba-1b7c-a62d-92ad-c257ecd08080@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:52:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: Unexpected=
 stop of the VM - Notice: Call Traces at boot time, rebooted and continued =
=E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): Critical: =
Unexpected stop of the VM - Notice: Call Traces at boot time, rebooted and =
continued =E2=9D=8C
- KVM Validation: debug (except selftest_mptcp_join): =
Unstable: 1 failed test(s): selftest_diag - Critical: Global Timeout - =
Notice: Call Traces at boot time, rebooted and continued =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Critical: Unexpected =
stop of the VM - Notice: Call Traces at boot time, rebooted and continued =
=E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/33479854147

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e20b644a0c3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155054


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
