Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D53EE1F8
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459379; cv=none; b=dp3octoio97lMwfxwhXwcDyZLsLoPwfiVd/Yqmb4fwVKPYpYmaAG4LVBC59okLxj9upVMANHByz5x0PqPJ9WxKNZ3JfzufDuVUWY/Ri+ZLuXoJVHKwVX7PRgvdvG7v+rLge1g0Yne1U/O9Bzws5abkruK+YL3uS9mlUFeA7zWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459379; c=relaxed/simple;
	bh=vHBcLuQEVgp31L3e2eNLPBo0fSKebx4qNbNeyskKnno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=H8QKFJoMGeNSaxbDtlGNN3nMAKsTLAFTv/cNOuYlgcpvnrZxgNWqTazvO4gGN/vTov4ngfZ9E0H/cI1y9to1y+9ePzHDHolUvJnFXcEZYQRHy8ZUOdfp/myRhlRPoh1BFnSooatLiga2mCiot+H70Ph0pihzvo5vgFoUKGCMJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb+L4pX5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb+L4pX5"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53396adbc53so52618081cf.3
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459377; x=1792064177; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nQoI9RjAFtgTx3dbUX8AyD3+mk07OGMTbKt1OSbaN2Y=;
        b=Sb+L4pX5CGRA/ULmXXDws+nPFdkIZGbpAaooqm41bgG8VO1UsGUcPIQZYNOlOASZl3
         2udLbSwr8kK3c1uMtRmsJeT/qntNqcVvy0ixa+4rHNTGgDXY5OUHBKpF1eUh5rNRlBsM
         2tBzv18Lg8jjYC8q0XGuw1jfRMrbiduahCDS7iXDulUpXhkk93NhD1n4ilK6xIOMySY7
         8OVdRKuo8SzisG4zqB1eppU6w9qhml2cv0PD6t3kbAj5I5cHzqWaSNT/2bQCd8YgWH+Q
         vksns6ephOcTcUKU0wc9xlq5rmgVVulwxmwhNCT7X52G1IRe3L1spqY4P3QIE3V2mNqf
         hvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459377; x=1792064177;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQoI9RjAFtgTx3dbUX8AyD3+mk07OGMTbKt1OSbaN2Y=;
        b=VGMdOVBcmva9YbrhbWAFNjyqg+FvS3reQb5qxLp6OOiYa80T29CP0rv3Dox8FFCVPv
         JAA+qho9TtL1NTJTg5R623og9esKHreAC+gKzXDqmKybeX8UgtWwBN4DIfkFL+EaGNyk
         Lc1ZkEGE9Xf59ocImikryf1cS7K/P8H36l8TnNCxAEh+9ObIALt1jKy4aAPzpn8J7wWT
         pjmRnkj5S8sYeBXdCuugi33IYnzJmFO00Oz5Fkx1tzIfi1+gh13ey6Osk8DGJGrg7/T3
         DWe8dJF4GEuDJeEnwHysrJ1QitKha08YFbuvv/VNkSXMQKkCh6pWMpIxSYBlqY0gYr/Z
         qPOA==
X-Gm-Message-State: AFuF++l9KfOtwvkecDkWxpTNcIgouGptfvSgcSVQnVaphW2zPDcFf7ja
	Gjjmk9GcI+kg0mK2gPE00f2oEoB8RKlGvewM481pQmTLHco+kX/4T3E=
X-Gm-Gg: AYBFou0cwGXvJ/uPbgT7yHCX8N2QtT8aYLXqvlk9p8ymNfvjWQ3rwZs83IiUFC/GsvZ
	yEYj853XrkqMbLtjb2IZ/NpSqW+Aj1k8u9p7imRqWHI23rUzh772LIt4Op6eBQSgvwd0Tep6HYc
	oWppRxk0VjDen3ZUDM7897zct9f8HqwLiG+OsIhB7CLuiwgUuZG/qhX5ovi984N6Yr7LUxwuhM2
	V0v4otW+5Pt5pnLaJeA4zlfeXNRi7jW9o/8EHHVsWFzCmIsbzHszNTp71VOWVVBOkDfPkBsyuTe
	1jW5l5aImHSHkoKjrrW6Wj4yTlg2hFJxpJxEXrCM4FOwKK2iVYxKwNDc3GG1cuLRWhvwZfeY3Pt
	DimfQxKVxDolB0jHyCOrV3nxY55oQkWJ5sorU1YgffOoGAFRfDf1B25dMnU1ZsiYzDThb40FP57
	to1M26h9i4FBP/IjtiddiRYaaIzqRC9yFGY6S/Wa6Qoizz4/Jop61m7sa8iIY1MVSW/MKr4+4Vo
	0yNjuV8pveI
X-Received: by 2002:a05:620a:7115:b0:93c:6450:9cf2 with SMTP id af79cd13be357-93e9b76d221mr960208685a.28.1791459377344;
        Thu, 08 Oct 2026 04:36:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.179.88.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991a0ab8sm448187485a.31.2026.10.08.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:36:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
References: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH v2] mptcp: push queued data on passive TFO subflows
 becoming established
Message-ID: <f8e8cda2-b182-90e6-bd16-3d454cf8b86e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:36:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

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
et-next/actions/runs/37764365241

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f72e0b60f8=
ac
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181531


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
