Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81924BBF5
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388962; cv=none; b=RtFylA/ve1Hc1faCpKkUXuMgxFz/8VCYruJ//b5nQBxro3LvwmfdPqXrT5MT7A72CNpJDfjvdmUM9G2F+Y/0gqQLWvx9kx/dDtcbcvw7yMzqkxSMNAihpoFMVRxF1Ul/lt2GZJ03l9LkWRw+5AKZ0YLfB1v+6FWlpy1sGnd9bzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388962; c=relaxed/simple;
	bh=gmy5yfoRmtuIrNoALAV2sGhjrp/LzxU2FbHIt/A7Sls=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ud4LAN99uwe8wSl7CteZHQtSIwxp35ZEvIrbUNwFdDwzoLi14wlSnvflN+UEyRCgrC/rdyXzX2yOsXcIyA7sLKNEJmPk/teRPXyk+1OqijIXqimQSQbWRdUJo6sWg2WAlFP5EGBkDFCQf+Rbf3v8EeGOOizitkZCv3rBJYkCxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKwMcNxm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKwMcNxm"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c07cd527e4so399188285a.3
        for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740388960; x=1740993760; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkULi/tTROgzJP9BPInoPa0rbkwxjNauB0+DIkaaE1k=;
        b=FKwMcNxmbls9fpEnOeiBGZXCN8OoEdiyBLxTuXitcCQIXC0+NpvQexNig7mQxSx5rN
         0rmLvEVm/5kAIYW710QBNgnA+NGpWLmjtqnCtfzW36HB3c/xq7ozDHQSA9kzPamP8J9O
         +8JJX1PtqpTZKFfjmc/yPI7RlSdIjgM09VWz1AWzFV6X2Wqk1EkcBW0zOB4HYw2iu+75
         bl4J8Tzc9t5qK4wtJYnrXUIMoY2Oa1j3ZWV9DAuYBah5UZUr7/jLDgFSR7y+FVoj/Lka
         Oaz/44FrhbErEMTzhdAf41yK7wBk3bh23F1Wu+2n9yUhxmh8YPNH+0G4VPNHQLD9PmGo
         l83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388960; x=1740993760;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkULi/tTROgzJP9BPInoPa0rbkwxjNauB0+DIkaaE1k=;
        b=N5+BLKw6/rxDWuHksVHt0Dj+kcm/ScvJ7J76Gx8PHDAaxrTDiV3rHg5BCCVaOARzoc
         Y7YiaXKeosbGJS89yNLDX9YlxC/3PkbWBZ+X17su6HGXh5pbJMVH0polnxbVN3S0uXxE
         7z9QYwtc+FVYN8vhwvkq7Y747u26r9LMq4GL52M35La03jOv+f+CZsYVhXYnLzN4kPSj
         P86S9/0PLJvdyMPNjyDFlVM6L1AuSpZEV3nB9UQ9Lmh62IxXG9M3txxj/GEHvaAv9xsZ
         qeuAvf4GiES4ehLJmcQMC9qMSib07VtHM065FbEHJyoj6DNgbp6GtH3+3JUv8ueb5C4u
         2h3A==
X-Gm-Message-State: AOJu0Yz+qJ8Xjqmh7okAmks2z7yOLQwJuIOx9rZDvz3mHbr50SF6c9dg
	o6aRa1DiHWfFVOss9rW4HqqTJ8LPWzDPvrsGcbd2VHZ1a53Uk6UI0JrM
X-Gm-Gg: ASbGncuVtnHcJ2Og60uwxPY/zNskP0FhPaD+rKRlxluWR2GhCpa/BSx8ABO2I89O+La
	csGIWTGdSxZo2ZAgPudqm7d/0jVutHOwlaSs4o6arOptkuGA4BVI6URiyFFd4YUhuLDArKRhQFo
	pP3T5p3Re6IlERsp1CLA3VICsQm/scZIJS1duHVtsLPsVJUeE+IGOnYMgdp7DGRKvOpJvt2eXTB
	A/BXJnQALilnGiH9vgacKX+m7Mk4qG1tZHwVpsQhXmIC0dieUlaZxOdMdK7fwGkpX/mCo3jTSWm
	hcWCM2+xQ5PhXw76jf87LBazoT4Dwz/HHHbGrDs=
X-Google-Smtp-Source: AGHT+IGNwvH5hnOvMwXr97vHxhJdx1LeDBOFJcqfgNnR8ugCcyLDrwsmdDmFmad7Iy03m2fh6+Cgrg==
X-Received: by 2002:a05:620a:2b86:b0:7c0:c0b7:32f1 with SMTP id af79cd13be357-7c0cef6430dmr1794668885a.55.1740388959985;
        Mon, 24 Feb 2025 01:22:39 -0800 (PST)
Received: from [127.0.0.1] ([20.25.192.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6b1759af6sm40270166d6.93.2025.02.24.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:22:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740384564.git.tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/6] BPF path manager, part 4
Message-ID: <fe2d123c-c742-e383-57d3-13f9769db9f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2025 09:22:38 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13493747167

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/51a90b40c97b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936935


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
