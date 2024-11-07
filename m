Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C3193419
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959935; cv=none; b=bWfbyBuSYQcsRjP1uJLTCsi6kENDasMKmxWEucyKEXCpMf8d+c3paidbAKYtuQRfzkZeEwGcVZDwOBdRz9tlvyLgtCnGOAFVTKrPhlMRZegVYhePeK3urb07IfZnvATmIuQKNkrA9XxEBGv8Ds9Z1wWcAwG9FbcTbkHJL1t9uU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959935; c=relaxed/simple;
	bh=xOBBGeA82EmHBXqRLfZVWhE9W1T9j8Pw3vuBv4oWDbE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kx/tKF/ABeMX9iDfGRuG0HhrooTswa186GV+VC1vUGJvKRIEFVNTANDgt5ZzlS/0XBjOwaGMWGLhFN1MnM0AZIjGXEQEmERkmKVEii4BQax9NYCQ6MHBRBXw2xKM0PxEOXta3+HinWMAWXfvMf3PM3Bq7hajBYmiyD/jKtcOn6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwYPfkU/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwYPfkU/"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46089a6849bso3739321cf.3
        for <mptcp@lists.linux.dev>; Wed, 06 Nov 2024 22:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730959932; x=1731564732; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg11BpnJ5KL5VKrt5LymAAoXuuHCTZcOStg0yG6O74M=;
        b=LwYPfkU/GsRani186WL/lSsq3d6UnD9youRF/jT20e5hNjNADD5iZmVAELLxZerIJ0
         W9ZfKSQlZx5wvaS5zoEUnEXSRQovk/jINVKCCY00jXo2eRqYRWz+VzUjV9N1WE7021EE
         0syOIEt4MsgcE7KIifFNvmAlbnKhkYlkBQ31vwcoWBVMtDAWFgPtAOdQ/LfmsFhRzCCZ
         JPQ+UX/FnmHWyOkX908G+8s79f40+B0mBv0WSbQ8f1E3i1SraQ+fBtxqc1hPg6uzQ5bp
         DZXRnSytp+OPkNt/yHL5oYdbCKR9SQHLaI5MOY3Wo2ipf4nI9f/IHAvI6qqbK6U/ZBVm
         yu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730959932; x=1731564732;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vg11BpnJ5KL5VKrt5LymAAoXuuHCTZcOStg0yG6O74M=;
        b=Wacfdyy6qlI6hG9naMd3r3eo63kSq2WKV0UkoEM0hX3DDz0Usx0qnShJ9sVDM/MD47
         50seaLdl18RnmLRgpU2z079elSi6P2GvKNwHg9TcP6GBbh+L5C2WvSbDxJ4B6H/scYq8
         rwM4q/CBEe7ZrrdtcBNss7dj+4FPGO3iQR9RorclyQ43pMrr7XDM6pTR3rTd+8Lxro0o
         JU+f93U84hwOwbPh/RX0U0AznbGApRoWQ7vpibrBnjNNXYHyY6qBF9ZAfE0hpCE3MuHw
         8C/itYHmwnNK0/ZSmlhGnYiN5SvLTJN0TN4pbDCmWEVYmOoSRlJ4WC+9FbUz7MiYVNsu
         FtaA==
X-Gm-Message-State: AOJu0YxAcskwdORZzH+mRR0doFYAw4JLM2OxcUWn4CGF6iBlqbp1fEj3
	jjTXZiukHwlkeSlfR/cQ0QpFRVMIEaFLG72YMw8xMSOVcmodLJZ+jY+I
X-Google-Smtp-Source: AGHT+IGuMfq98BZat1DulYNDbqAHt2wpUyOwFvtRoZ/6VDiR42ipf/cgYqKGxn1SSQQ8W8Xedqj5+w==
X-Received: by 2002:a05:622a:152:b0:460:a415:bde4 with SMTP id d75a77b69052e-462fffaeba2mr9328091cf.33.1730959932405;
        Wed, 06 Nov 2024 22:12:12 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5c976fsm3781211cf.74.2024.11.06.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:12:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730953242.git.tanggeliang@kylinos.cn>
References: <cover.1730953242.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_address bpf_iter
Message-ID: <e0048aad-cb33-96e7-2e44-4b7906f95249@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Nov 2024 06:12:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/11716784023

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0cf3c0bfb619
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D907195


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
