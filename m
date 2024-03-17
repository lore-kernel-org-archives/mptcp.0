Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D015C0
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710640165; cv=none; b=a6qpoybfwXN/DsdGTFnHGTGnOttt81pR2A6UHBCFsHfjrT9egvljvJaJ4j/XPaNu+qWd10rd0JRll9/IGczdntzjGiiWPRnGqTk3I00D96qV29Qj62JVnvCHM+z/aa9eFIbafVpb5aLSDPtA2qs18590bwzG9oGDGBn16RsOGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710640165; c=relaxed/simple;
	bh=EWSVJhHoOvO0pK3EVuMOFaeTwXHukeOum7R4KJY0/Dc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZEaKyfuUV6B9z39Y71cI+yXVNIxifhyS0MKC7pR6z8i8rqc++lr7OTyT1D257GuoxB+vGFRGPYdsKejRWaPtONEntCJ72qY83XmKql7VoxOMaMEscRAkmqbax+/o7aosjaQSogr3bn4uKGVyxPgDfrmLsxQMfrtsXklfibOwPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SowLFDKH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SowLFDKH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6f6825102so2023962b3a.1
        for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710640163; x=1711244963; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GP8p+FIR7vMdvOF5F19Q2aaOlB+PPMxY/PHC2LtHbk=;
        b=SowLFDKHJbSIw4tUq1JQ78gcNEQwvhgRTm5C9SUxCSWuH3FbX724PVopkBR621LIp1
         NJhylNbIEyqvPBF7d2JFDiMm5jnI5dItTBqv3VF5wvyk0uz/vKgkyrO0ajrnHdqxoei0
         2q7bK+2+rXOQ5KyTANTDMI7Rov8+RQl0D2maaSjGvkn5w7Sv84+TvBkYuemAVaDKuvwx
         r5Y+j3U7wkbduvb8VE3JZVCh7JiX6FTj5+GtUdWYGSliU5xG10loJXD6WVNU6Cufzz9J
         hvI7RqlpRu1oz3kLf1ggFjUilhE/ANYEUcm6SxfgDyVP0HrexEtDpaOjkD8eTDu9S6T6
         yIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710640163; x=1711244963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3GP8p+FIR7vMdvOF5F19Q2aaOlB+PPMxY/PHC2LtHbk=;
        b=HKSy4WmRkROHnwsEL8gDkiSP+TRZ1kn3Fc9OdhsxtlDXfDxWP6NRbH44sbEeU7uYLY
         KJ8UiCLmRMThO1Se0GNJ/ORzLdTOHYcXxLTLfSNuyhsrmGzusi0AqCfF8ES0g5N56/HE
         jsIvzdY8tR4YAJDaFrVrqk5o94aUXoDdLzlhWOfFQdA50xP2fGfCdqniPPAID567sDZx
         TbOd50vz355Ah47WM8vrCiBL6zV4MtpneF+QDBQ/pYRa51aA09BX5hTFMJoPkL7tJq4x
         Pps9xN03+UnPfUMtuIsBmdXwb2sMkIRF+4QhSGC88OVbOQWYPpC1V930Lj6dlF1GFMk1
         im5A==
X-Gm-Message-State: AOJu0Yw1/iY10zT6BGqPzXrhZAmMXVbd2XHQyiZsHI0fIaBcm3/Wg7+L
	U3QTU1icVEIO+rpd46V51smLYH2SwdRHken5cLphM3OG/5vkKG3Z833efzM=
X-Google-Smtp-Source: AGHT+IF7rkqn4CpKXDE7DbBv8FZkJI5RtsPRK8c1e8yAR2kblWaSjxTQCmcQaT+PSwBxC0ig2Heudg==
X-Received: by 2002:a05:6a20:a105:b0:1a3:52d2:5df8 with SMTP id q5-20020a056a20a10500b001a352d25df8mr6027615pzk.21.1710640163212;
        Sat, 16 Mar 2024 18:49:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.93.226.164])
        by smtp.gmail.com with ESMTPSA id r10-20020a056a00216a00b006e6eb8e07edsm5104341pff.50.2024.03.16.18.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:49:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/12] add helpers and vars in
 mptcp_lib.sh, final
Message-ID: <8379b762-a2fa-b50e-e029-9d9437d49652@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2024 01:49:21 +0000
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
Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/831189=
5129

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e8e27b9f1f07
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D835874


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
