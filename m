Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599F259C
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260094; cv=none; b=LQg2oClyt0y22/Z7iSFFquwTSmchxtit9gkFwSyUAu+tzVoDndKWGoY1EE/cu7wBxLt3901w3RtyZC9fdLPA2jyNbHjkyT8VTCv71IJuKaGbxhRhEHwXTmUbfD6yceH7cW4blllS49i+/jIW52EG59tXSGndLKmn+Nlx0CLPLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260094; c=relaxed/simple;
	bh=yFp3mMLqLn4lZ5kaffMonqFGDsuR0/PmvWlSbSx7Ikk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=h6EnXdyw3lCbrJus8CXaNpkm5hCMICVSwUp5ojFguP1pD7wZbHKGX3K2rQWqIcWV16H7/St9KWKK9z7ADxu2HgHvYufQTRho7FxT/owLiHinn0iR/frwgpSK2PfA6brGlBwHCAkye0CS81/8TTTozx+Fd/RyFqe5ialwVeDJ8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFseAGIO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFseAGIO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c54a9d3fcaso41212485a.2
        for <mptcp@lists.linux.dev>; Wed, 09 Apr 2025 21:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744260092; x=1744864892; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzQvDHcrkVFTcNpuoZJnRkwNvkzh7bz3y+zWyH3DClw=;
        b=UFseAGIOmjhqZyGWwDyt6aPNYwflY5n4ifuUldlooBvnbr84/h8nzbgoGAlvYy2cXg
         WNJzBz56Yt7t9+BZK2GIuP3NI6dmLAk5OgfLy/qBflcXefrqxPcqeROWvire+HGJksi8
         VVtL3ZzpFJQq6NXnGgrOkB7JImRDcvSKGO/j0v+mPIDAQRoB6IkEUICh4M6K2nwBxYgu
         9Aiv+0MndBsm5+tO+OPVvBNXvszNRwHpwd8HkBMFvgHsv5ObMFCdvoJ2HD8bXBXbhoUb
         of/Xt0ZwVw2pJRHYjN3xcGSVR4yR9HEYFgKLWqdD3MDNTV5WHtkVUAq3wB31Tr7R2BLZ
         m0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744260092; x=1744864892;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TzQvDHcrkVFTcNpuoZJnRkwNvkzh7bz3y+zWyH3DClw=;
        b=Veun0eFLzFXg11bYOIf7W5HCRHsha96pYftlDPZPyrdaxKu/W6gR24LzwDIgB4Pfi1
         2MF+86B9UQrLYZ8F3mszMMzKNcZXpfGA9wOW/KFk13IpW4BwhW71fNn7kti1jVx3YbZI
         Tli5UrPT3hlTCi57AGTdrvrZtToeMCLjSIc0OX7WJoel9Qpp0+AbFvBCggjGCsn1GhAW
         PBU5p+Z2H4b14XR11cmO/pzNXFmYrhq2sygidL6pr4r/teYiJlRKz2sNY36lV/qHFsor
         zC+4u2kMmAogKJd3gqr1gLjuvNbWBCgqewlwuejzqkd3DHg5oolb0ISp1CfIHVLgOoml
         sSlA==
X-Gm-Message-State: AOJu0YzxzrCSl3gnbt/2kc1MjF9ijJNp/s3mcJ5isF3PvrV7eDdjWv1r
	RdzCHWP+CgWqVun4MwDoUoRNbVkpb1r6wGgadPtKUNuSBKNdTYJnpyOl
X-Gm-Gg: ASbGnct0mQEOb5BEvfmUYW+Fhr05vpumNj8ypihQduACXO/hikCkoWEFAOCXv1kdS3h
	HBC3BQ5QwSbPf2lKFOghKVhcewcjZj1aRHwltk0RWvUfwrK7Ny9esF2BWgxiPjZX+z7Wqhd4scB
	fSENFp+ysW0CqOxvsBqduIZaXLIHZBFZs9Gcn7tXAGWeJsZedOWmhTatPHk4ZNobStOx+wDSRJ1
	uynZgbNryxiowqyg3/UUCaLnWmylvykD2Uo0YcL18INAqtc31F8VowL4w8sjA1pUddkV/wuuMHc
	yzU2qDYXpZcqhQd7RjHSh1lltpH5cq+wXmYvWKyE+1IJXxyzRDte588=
X-Google-Smtp-Source: AGHT+IFnJxfAQIrdEDXoURjo6/5HUnloca5UgQuVOnVMJzrMpA22JC5AxJYzvWo3+7XgpXh53q8brg==
X-Received: by 2002:a05:620a:2596:b0:7c5:9c13:2858 with SMTP id af79cd13be357-7c7a80a2b50mr133826185a.0.1744260091873;
        Wed, 09 Apr 2025 21:41:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.223.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89f9885sm31825485a.87.2025.04.09.21.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 21:41:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250410025931.1882967-1-martineau@kernel.org>
References: <20250410025931.1882967-1-martineau@kernel.org>
Subject: Re: [mptcp-net] mptcp: pm: Defer freeing of MPTCP userspace path
 manager entries
Message-ID: <b13e1f8f-7ce0-838a-2280-b1a7cc0709f3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Apr 2025 04:41:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/14371524037

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b2ab62831ba7
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D951816


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
