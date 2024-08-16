Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DE7DA96
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815043; cv=none; b=fmVAPgBK+xCrvViXzhNUGyiPeQ2hyL3limE42EsqGzTr1nxCw5lrFhyxsuhQc/H/IAvwhTpCDtksvAA/BZmJ6cyGjY2EaheZJ/Jg1nyKNyuNW2vpPuwNwSwHFG+4JIGVs5pWxdn+1Etm4+B06knpr/eK2Go6HFCHH55+zAJ4t2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815043; c=relaxed/simple;
	bh=CDWXMmj8ynrhFURLmk75CUf4LUMxt9LcBly0VJxvafM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mx7xCvftkllpBrkPP7DkEIcF3VuZ/4naEuz7NE3cmUS87nOWvedMnS6xct9VwoSUar5+UlzZG/Yrmv5447uqPki1Jyfo8Q4kbH/k+Hlmiawpz0wwFno2Rzov0LJTlJaLhzOR3jEsaJTWvVXdQXSa3DmG4BtPvxlWbN9HxpCB008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP1bA4YH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP1bA4YH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201e64607a5so14616935ad.2
        for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815041; x=1724419841; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cewYVEuaw7WvMFlghdNPbnu+zpE+CZCZ5ZBDwRqDbw=;
        b=XP1bA4YH/eaGgWJRmu30qYHhmPoItVcAiq+pB6ZXiIG5HlXgwWstNCeAlY8cld13h8
         JlcHdkcU+EMn7c0YW9ENFAVIdf2Z8R2Spt76Q7D6Q1cME+f96zdwBtif3LgOgSBg4RwL
         bEc35/pvvopM4C7vVBxkUe2HjNvouZ0r+pNYhgfMD4769x1SSbz9WDOP45sDzbFir4nH
         skGcpzFNgU2gAdHVAFILuA5dVw2n4XL1t63aOTYdDCaxy/mqG4vJFh45OE6tfOq9QEBO
         r3G5KfKi/6jBbBwgBzvwwlBIDszaHN6eRVTpGB34zKu/ko7syv1XJ2VpUDK5G+FG299S
         ND+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815041; x=1724419841;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7cewYVEuaw7WvMFlghdNPbnu+zpE+CZCZ5ZBDwRqDbw=;
        b=L6aVU3Q973rN1crEozCgJExCsIEwUw0QUL2+cm8xfg3dbRx4nXwDR9u3D9kUUJbavM
         VCPPADWs/cAWyVSavn25EgD5zKDW0Cf1EDKGgfhSYwO52bWj+OAAzshz4OqyjFxRl5nU
         t2F9lGm//rdTTlojK5Pf1ordYX8OmzUcLKsDlCrcGegRpuHv55qABMTMBZbCVDH4F5ad
         L2zzyMow9ul2LzSwoorYCA/VohX9KrsCX/jzZSZ7H5Km0FvglPes3dcanEYHcp5zTVv3
         bXueuVye4l3o3e2rcJXllbdSRguul9t1BJBui/hRM5FrPGrphsv8PXeBYFQ4UcqZCCxw
         Gr5w==
X-Gm-Message-State: AOJu0YzzpKJIsGhurDUJom5xOcCK+z0iCZ6YntNvxRlPoZYrB8zkAv0T
	/a4bPSc36vf5dPOI32xUuRKnVmLHN3SskcQ7B3svLafS1sVzl9T9BT3E
X-Google-Smtp-Source: AGHT+IEeuc9UL6ylC/zN+1gIuqleAvi860FrZWhVq3hizS7FRAN629tOiUQNE764ugWKgztQp0xsgg==
X-Received: by 2002:a17:902:db01:b0:202:5ac:fa3b with SMTP id d9443c01a7336-20205acfbccmr33323365ad.19.1723815041141;
        Fri, 16 Aug 2024 06:30:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.5.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c4aasm25566835ad.93.2024.08.16.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:30:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID
 0 endpoint
Message-ID: <dc4ffe7e-27da-59da-66a9-54da2c60e49f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 13:30:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10419016942

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de4d0b5876cc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880310


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
