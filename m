Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A643D1CAF
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534209; cv=none; b=bPe7x2Ka+LIBQRsLqCP0leW4qJlGME9Z53Wu/R0Hhppxz31/PLehYphP/y25cL0vJfE7GbHVG1r0wVpF/yX46C47EDRMdoqYxkZu4WwKibJFPH5oMBrOX0fhr2Cnx1ORePMr18iuNPxoFEy/H2bCA4GQX+zqvz4h6jfdDYklSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534209; c=relaxed/simple;
	bh=sPKj9n2AwEquuCxWbgJneCvZ/8bACUPmoJskGGw5tq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RCvKO9iXt0P2p3V85VzcSrNVpOaQl17a7mQ2KBFfX8YbH1cu7W47UsIpgpPnkwLsHU1ZjDfIAOGUhybD47y0CS9hd+vtiyBV0BXAc5bqF7ABCqeKGr+FBS6dRFBWrQDPlmB4688P+wrUEkGERpZxtoPUqwmeWtATtrA1pF8a+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYsImqwQ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYsImqwQ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso8061107eec.1
        for <mptcp@lists.linux.dev>; Fri, 09 Oct 2026 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791534207; x=1792139007; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E4Zmosob9qQkVC05/Nqqmw72jsR5YaY34Xqb35AuiZY=;
        b=IYsImqwQYQ9eNyInoxChpO+pEeZ4UM+2OJIEMjxucF/p7+LZiAO8qkS705n887Vf3H
         mmTt2qzzgRnUySLa38MpoOfJ0EqnwWF0QocbF+zoItqfK1CtsOgHASApUGeoN3cKa+ar
         WIO3O2e6gsJhbWbxTqS5gs9J2Yfwmr8EDGKPUdBF+uGcXiLvPTb3a5mIeV64vYslfUC1
         85gVwwV6M/EYpjt0kkEuGkdomgN/+QnAPjqLiyuqx8dNFJmtV2+6BAJNoZNZRLRXxYGV
         uKY4OXEEnZoh6muv8NKB3GGQu8RYb8u6oU+Wm1zFT7dhZwO449sorV0hYl52OjbWK02q
         Wrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534207; x=1792139007;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4Zmosob9qQkVC05/Nqqmw72jsR5YaY34Xqb35AuiZY=;
        b=1T0lzOLF97QDQvRlS91JZldMHrU26Y3SwPDHcSQ/AWi17wwaYu7gHpM025Ul6Z0y0H
         jaQiZDCc6yqqV3/ZFt+4k7cn8kSvcKXSkThfzGhEIufGcI7TxAY1DNF0cwaISS6IqfsP
         drcy+WsukA5AB8+tNSat6hmws037H+a4HNRDzyR/LKIlGtfmkE65wD2hhCMansYaBy+j
         k1gOcHOIsZkKPHNqRrya2p4MWySPnQuUjhQWCscv1BDzvXLWIj0rDVUqW5qk7zKZdNDH
         2YVLJphJ6OYaJfJeHhUyj9ld3IR5Tb8BLUwxWnUhuIa/Mn1iQ2EyTSrFOybBHdVRder9
         6Ang==
X-Gm-Message-State: AFuF++nDic5MEgCLdf/aILoGHBIt1eQdc6KqBgVeff6GqXY9pz9UNtoJ
	E0IAMcgoQ5MOMHIC6ckH45HEpYBx+K6lDRkJRF4GkqneC0/OVXHpyajKLQpT
X-Gm-Gg: AYBFou073jBL0uZ2jvj4ehz+hFk3ZMpbuKskerPkHrhFcOqkyfc9A7NhPJKDMRal/x2
	krdJqlWm2CEDhT5IsCMBZHXnvDfiESR27UaJfgq+pyp5FL1BG/Hc/Ife+Knl/igdHMOZWpX6GLt
	0Qc48vtdUHzcHjIcBDKiPFzL0JNbkfmawBj5HxtshTPE8EOirogeA2t2qfLB2k+1RIqw6NyfS8L
	rRXaKVdPz9aLRBSEAL0Q0ChpjBEwNdkdnBjl6dsQbBdAw7e+HD9xvPqHSnxuPBMUaM2RsZ+MfdL
	2m2lmFHgQGAbX4b5fpXj71Y8t0bU5lvomzkzD2y/NKlKoQ4hyFygeCN1+XmKdQKMB5B3h6gHH9I
	Y3A9r6jaBelqQC4qwvsPQVpjEG4vdQsH7XWG8pVuMdlzPinLG4ZwdHevjzUCtJIEojPcCYwI/g8
	ckzNVD4a920m+QtaWZup/j8nil09Aa9EW8iMWs7yXGCltnwxJpqRL1FoYcHhAP4ona8YZ1XNjCW
	uOjVoLkbRiPpA==
X-Received: by 2002:a05:7301:408b:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3537df95584mr2457684eec.16.1791534206689;
        Fri, 09 Oct 2026 01:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.210.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm3950266eec.18.2026.10.09.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:23:26 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261009-mptcp_remove_addr-v1-1-4471d460e026@kylinos.cn>
References: <20261009-mptcp_remove_addr-v1-1-4471d460e026@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_convert_iptable?=
 =?UTF-8?Q?s_to_nftables_for_mptcp=5Fjoin=2Esh=22?=
Message-ID: <06ee1bc4-1290-c51d-ced1-26d66846b2a0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:23:25 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37900753671

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/634b3ec483=
1b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1182160


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
