Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD04A35
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095032; cv=none; b=XAybNfMc2Q2t99zb3TtZXVzy2US5olY1CtcflTYpwqzBLx7FuWUv8yaTcgMIXdI43wEPAKcUaXVDtdhcKVZ0cBHLsDlcTbWw+bRwH1v5p2ZRGAN/87ZCS7lqpyl/5Lj0TcHOpJVh/W4hE639SVnu2UHLiaExVKJzIp46k4SFe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095032; c=relaxed/simple;
	bh=j5DtKaBarwyrBx/bZjHTLNA+StCBCsDjAk2nxh7j6Zk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Hqneq7gbPPvI5BrJqVcNK6LPC4ix5UnZvSiiferwrsvgBak4dvlYjzrUeEB3U1ap4jg9GrGCwVqoeNYgSSBW3sPWNpr0pnImXH15/a7I8Xzr1DQzsr/JoaJMlFMh0q1JHVJooswHxOKx8YIpC5aO1c0ukH5bUhO9qp1bPgFTbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUuGyDmG; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUuGyDmG"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c59bce68a1so397972785a.0
        for <mptcp@lists.linux.dev>; Mon, 02 Feb 2026 21:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770095030; x=1770699830; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZnxXPX8S00VJPFta0YhOCmAS9z2XtAcArcvwohFxTI=;
        b=SUuGyDmGJI/5kFCMyemqUID3taM29QiqtbmDw36gdSg/hZMfpt46ecw2kj46MrAaV5
         x7qpN3xLt48wF5Gmrg6x/0O+wqYKcL+rlkXeETeCwWIUiEF7JyLB0TFHZOUiLMvi9VTc
         pXxs7EFlrRb2dqxKTo58QpwsSJDd1Bf/ox9NpuhZPxS/0bf2yWNSiJZZltMjJkjS8zJL
         hkFHGy1o+uQRx2LtyCE74Y//o/ZLDHd07nBdiZqff/vOk7FuiqXcizSQlGbd/DcaArQV
         +nIoRwE7JNTfrKLWsoIqf5zR2zRsUWBVaEKLo5slaasnivjVVqScyr5+4Iy0LYrRqN28
         8Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095030; x=1770699830;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZnxXPX8S00VJPFta0YhOCmAS9z2XtAcArcvwohFxTI=;
        b=RJ4h/5sy8/tV4PNWmxG892yx0HQnWcK4pn9/pkG3PSVgSLnwLgsWFeeHz0g7g5Wa84
         T4lcXVgaUo/BGWWDO2ZNQjUm5iH13V4wQ8NqSikkfE9wvt2F6I9ffff5ZccuPUz3Ci9x
         oMHwcHGhDQdADEapmPNLkkxXpkpjbfyjT+eR+ycWHhVVbqQqUvjjmu6fvZsUnLNbQhJt
         VVjeSIBES7lZthq3TSOdzsWXXJVU7JSJ+0q0TnJadIxwHghZiEpDmd/RcYD5cQ7QRMvZ
         xUxRG8fnwlOWVyQ3ANEDwIufE2qppPQRgWlg4ArkzRVRgQxw1v0ZYPDEN64Y9fnt5Rhp
         LIFg==
X-Gm-Message-State: AOJu0YyfaCL/HR+5LGOhsYSnnn0Xmo2G70FcO3uWUtjtq5rEyN2Wym9K
	KZvjuzAsD0oPDL5b5Iwa++5V0Q7evqLBRcmUGk6a4aMYPi8UwIlGLhth6B6SJTA=
X-Gm-Gg: AZuq6aJaNu/I7i0Fm54q7PvSJrwAWFgUPP4by82afskosUEQgYPVNnljqSfoazBfav1
	WoiRyF86VBTfdBkG2CBO/wfDGloDd2v25LqLWmQcvlefWQDirlHHl/38GENTDGXdYH7Rl3XO2YV
	ywDqzE7ulqzVHuggun/d6GLzfczH4nSakk8O3XkTBUTBSo05flbES1xnuWjfn1payNKYinRcAbB
	g5HfLMUZbiH0GcPRHvq/z7/1wNUXCwkjTiG4pvaazQmenmNKwc8sK0Q477SXO44bSd7PClO3zQk
	v/lfh4VnAbuW7D1AqrR558zjFzqL+w0gTt36gDuvzgiEaHz5bqOLgITmI0OG29r9CPHsZzpXObO
	DrBcAjdAtiU3D+TcTP9T2U3sdjRKxXAWpBmzEbnbWLWpEGYL863BaThQta3jLtfWeBYwtgW7Mmd
	DEUoQFa5FSaIM07F1fOO/Cx4as
X-Received: by 2002:a05:622a:19a8:b0:501:51cb:1371 with SMTP id d75a77b69052e-505d214b043mr171932411cf.17.1770095030074;
        Mon, 02 Feb 2026 21:03:50 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033a4dcfefsm121276411cf.4.2026.02.02.21.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:03:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1770089761.git.tanggeliang@kylinos.cn>
References: <cover.1770089761.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] add tcp_recv_should_stop helper
Message-ID: <7b42aaac-8844-e003-2f9b-17af952498a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Feb 2026 05:03:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Critical: Boot failures =
=E2=9D=8C
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/21616628959

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/47f73d0cc08e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1050056


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
