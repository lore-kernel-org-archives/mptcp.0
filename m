Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3076315785
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402008; cv=none; b=FYpPnw+/tomGtr/nBYZFV2VcmXDsxUELl2CjEG1iVDDDCHaL7lzFAFrzNoblfK7ZxAFxlw21qUBEJzgz9waqw/jIqTKkevsBM67kCn6RKk/AIO09xB2A5rLepxUa+jBFLfGxgyLCXE5L8ydBkAPyfFXP3ulGvSwApBit6gt5wsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402008; c=relaxed/simple;
	bh=2xnzfhhbJcO/OG12Iq7d6SSZtH9SHS9uCO/hxoyk2DA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ewGtdGE61pVALC8PTUF6DjlJBh/REyX5SfXQrUKcCytsFGV0T4f6krOHUQD6kAVdbeGJMIOD9CCXoTIWMINfTL2+WQxAnE/Py+RnqZ7G/QzhYd+MvedPyXLZIy99QeafWwhYPM415/bQzJzbWJMmUIn2cFnqwY+mrlh9XP2044Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ5HIIiL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ5HIIiL"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f57db8b5a4so1394589a34.2
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788402006; x=1789006806; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9p63av6CnWpIrjSIJ7kCAV65SmeYICpbPe+o4EqD/aM=;
        b=jQ5HIIiL7geHcob9kGD/iNFDd2v1iDCh4Enf/BaKcz/JIXPE6nCh6P4YwC1EYIrT0u
         9ui0XQWjz9bjqWt521mS/DlxF+enma48/Dz6jqYTguf4Mr4+sTTPQMedXr8Zy7vvr7x7
         oHiaAImXHoPyp/NRgcdl5YLJadvw9XPEajFbiGX1KhkFGCorp4uIuDATjnClEUqDVr+4
         BbiN5VVFzPmCRzlrIM46QuE9za5A4XkTMOjlVZsXm67dWm/WB2tW3EcJj6x7Gd12vOwf
         NXTCBfm/07b2aTfxz7SkIzbSS2yzENfFafcrXylBUdN+8Uus1QoX7ja9QIG4pH6Z/1Cc
         +Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402006; x=1789006806;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9p63av6CnWpIrjSIJ7kCAV65SmeYICpbPe+o4EqD/aM=;
        b=AzboXoKX2rEP7lNZuItsI19v6CXZ/i0si8LBdlZ9x3WF+JNnafxgf3a9310vBOWd+z
         Y5FHZeMatWbS9L3O3+EsXdM6ijvu1QnmFGLJoGdxPtRvf218vDLn0+zJmIU+ijS05t+c
         Vq9X+4e5R2giWq40xBCILGHCjFTzb0InpVcSDx+UmuOPanwu4tmS0fzkc5Ta1lUgNXl7
         pJ8SdktSPueHg1EcBXaYQqh1i8Dx6MsGrA87r92eejsAdTrisN/MhF/m22EKh1aGYRIV
         02wzhjSRAKE5n1lpQf8nEtfq2X9OV0XtngNuYkdUKEIros2pE1AWRxdwjZdwbzJZ84l4
         2Nyg==
X-Gm-Message-State: AFuF++lgGNmvwq/B2uuBpOuQJJAKMVQP7gt/Bot4E+EoIj2StbZVA944
	w2fQGsTKxJk0PFZwZoQb7+vPoAk7Yj8Wu61GT6nF7XjPx0gF/aKe10HQJJ6w
X-Gm-Gg: AYBFou1ekj7cOnOEwdLTr8/2aD1BT0Odf4mLJJCGakgJZnsurTHWJEfmE3P7V0aTZ6B
	GGQNorhuWo/5YEoGf4sVPnvgb2Dr9AVwEwJjMMH/AQ+rFwFMLfGPSL7ZJkB443eQQkfACZlurmK
	UN8wWn4nuvwsl6r6j30baWEs3XgK5y+c923ybsVM6inWxVDUKeGyot4FD2o0uTlI2Zz+DIMLHcm
	airP+Q6FIBVgwSl2ADH1xzHy18Q+PIoKqtiFomWKK0NuZcf2ajjkLn+0ZfD2A0pshLcWkoUrPF2
	4LihNGxnlWFwpYNmox4LyvhOXyi8ccHUWtAzOGHnUdK0QT+vWOk2/7snfXNfnll0CSO9rwc4UFb
	olBMhGMJeQ5P3qEYdeMH0ZLP8wcUL+n6q65RdDGweKl8I6b5cTG3YKhfSIZzADL9I9al37CfxUp
	20Gz3jNBkrmiMySQv5tnsdtMFSMxwbvSCdqQrE6/WbeYNpisrvKfScr4FbeAAJisupj4/Sy9E3M
	A==
X-Received: by 2002:a05:6830:4423:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7f77e8bf811mr8611122a34.1.1788402005447;
        Wed, 02 Sep 2026 19:20:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.15.228.209])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74f3e8580sm3923327a34.15.2026.09.02.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:20:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: mptcp: convert iptables
 to nftables
Message-ID: <666b89de-733d-5474-c73d-f1a804bb34df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 02:20:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33704019089

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/22c271f5ff5e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1156594


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
