Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452324229D0
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010456; cv=none; b=aA+O+EyBPUqO4fAmO+vF88qaXyz91oUPOn85CdwHV/NlQ4beAje0jaz+mG3Qz1bmHNqAQrFtVVqOb9joDkHhLr4aqeaT+ITKKjcpmhmcVIOw210NXXV0i1hFK4/TjiDvJ/VW6Xki+iF374r6V75dy8x7xAMFSfKGc8jlkuOL1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010456; c=relaxed/simple;
	bh=c/ilc1jhwHAD+7DSvNZngeC6D1gB3LVpEGO34rl4zsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rXsPIG7mrM6+q2nnNpJbLIwu+1eZC0tsworVEy7KGgdgtRWL5PQAycWsK91xvgnKamCv1o3tRySUUmcOsthBJeuPTl9prIXluRCUqYP2EbO09yE6ACGz2zWBL9NO+usc+nrclzC2u4t5hG6hsF5AWwP/6K4wuVDa734LJuzodz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAXl/A7E; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAXl/A7E"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a449c57so11484191cf.1
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786010454; x=1786615254; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E6zA1e5lWudpKr78UWbwRFxr9VRm893fz42Vp9d7zwo=;
        b=BAXl/A7EiBPolNgltH31RO4ilcWW2+Xu9JcMjJuitBIXp/bQ8gLKyhntsfxudz1Ot9
         XNx33fVbkp4Bwz+oN3ONGVsFUilDhuWeDaQRzWPisOEDT9kkfA1Xgl3i1YvRugGnQPvh
         QoFyqmIQLQXpAc5dt8tqsVb5384ALkbUq/CnY7d3hB/6JD3q2lpV92oa3wdG+jO+q+9S
         8TviJxRN+/eq6OpbFanF545QXBXmYVlWZ65AIOiqn70w96xErwTZ43IxCjSnv5fqsl0W
         Uy5knXzJ6kb+suL8n4HMxv/flyrdGVBdps3t7sk+i8opySPkSQbIrfHJd/VgmBaEf1ss
         ZkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010454; x=1786615254;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6zA1e5lWudpKr78UWbwRFxr9VRm893fz42Vp9d7zwo=;
        b=Dzbq1RlXHE1V7pBQCR09J05l9k19bBI4A5iGrrA4PkNO8qYO/TkS82Zvyxna56l/7X
         xvapBjb+nmsDxv9QXZPoro3OGXBZGOpr3qrg1NKHFv4rkegSTk8DnicDG7aMZWt2klWm
         k/hF7wG2T0Cr/ltnZU63dJ54n1TQFKnQlyrtKfNGTX8razYmhalx/yZw1MVviN3rixNv
         HsiPumo8joDtFnEbXGP7cGU27sHRpGnh021jBO8vYP/8ZirmFxqpogGOB+0b0AUm+Tq+
         aAB2I37d2jCheHm7VR3ndQaBp7ge4qmdkMYiyn8RBfv1nQH6x+yo2lAuQ9OnjHQ4iWcF
         unRQ==
X-Gm-Message-State: AOJu0YwRPqMwBPWD9DL/W7qf5k+rh7xu15Oll5ZcqCPbScR0kmoqVJaF
	sR2x5nXXkr3TorDFQH0HKArwKLvo94oGz3x0hWi8NBRkWMam5MifFyeZBij8
X-Gm-Gg: AR+sD10TPnqaT8+RNYW2oPpqguDurlEtosgZzMHZiZB/ijcCey906W2WUazxi3CzXnX
	F7PFwY1z74daeWvgAOyaovOa7G0+aPDWIbkW0OtSx2fKEQo7MYZPLx7r1IpxEdTFKRZunPOtYb+
	UANRCa1YcZaTNgDXGAP+ti9TUDrL8xRaWhy1/Yrnk/2LsKMiq342HN1KTAwpRvd+TE8xjfoPnNO
	0ClA1hX4MYAfvBPdAu7/YrhNqzEMkwuRqy7BtstAwefULiwzTpz48I2dCEnIjfFEga8+9JiWLgY
	KIoQIQHbRjmIdBK71FVraAaxiOBQp4wxQf7j8XuMEnq2EC0isgfXAyc4BnhSuJglqKJBsj2i4WZ
	OjhmHrI0O5ydneUzg1JHqm4eC5nD+yUNIGDeCSBNtIrXLp7jgn69A0O6yn8vUtGxaLad2sNqohK
	c9h16MSpYMtNSDrUujtAXG0fNv4AJmSoFIXcScoyDYm1B1FA090HFkxZlj/iCAM+XCmb+n0tZSJ
	A==
X-Received: by 2002:a05:622a:1816:b0:51c:1f97:e852 with SMTP id d75a77b69052e-52ce5f6333cmr131409011cf.6.1786010453897;
        Thu, 06 Aug 2026 03:00:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce87fea0dsm35819741cf.13.2026.08.06.03.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:00:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
References:
 <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/6] mptcp: pm: userspace: properly deal
 with the ID0 case
Message-ID: <6d11d516-4de1-2dfb-d2c0-23b0afe07488@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 10:00:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310875=
51998

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/63d11d6186ef
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1141314


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
