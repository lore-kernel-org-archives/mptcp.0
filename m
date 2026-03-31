Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B139E6F1
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952031; cv=none; b=EK83uTQ/ltXJ1X29pVXtI2x+kHarPvee1DHG+WaH9wwUBXxG/BUso/lkYcJIDdaJV/9QLYj0ExCKgqFGoBZCXbQSp9ybUYdm3/qnvKMskbgbBmR+//b5PpaTO0Kb5ZptH/ltllG9Bb2B/L1DLcJKRyz1FWSgnIEMXTNTvWl2omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952031; c=relaxed/simple;
	bh=Iq2gUqLcS5bHJ40GmHzAsxDEENEDzxXtwZq2Jp8ZByU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=fXLZRM/qJ3FD0h2RvFsIPBOYnayr6Ak0zInab59RjPB8ibo7S3atd3dd7BhVSRyNS6adOt3i9YIjMLuq1UrN8y7avTi/LAtMV3I3THyv7ntnhYTuFenOjLTfFpxgBWILh84gVl8L6KbdtUbSqhZnJYT20EP3lcZIV00ot4T6Xco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO+GkqCk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO+GkqCk"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cd8a189f44so486079385a.0
        for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774952030; x=1775556830; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T6EIlvZH3JF5hnFE4p0T/H/kTlcD6UcTMySHi2XMMo=;
        b=aO+GkqCk6hi5p9cfTPn5vYSN1seDa/wv6zlaJFY9cE8N8XUV+yOeHVFBw6s/zX2HB4
         ZuikJUTAWOwzZQO+7A4SIlak6bo8Yi9bajqhYjYUA3O4LtBagfbCuuOB4htpiohQzDZb
         4GaTpV/NHJEro6/xscbFZVFLjO2wyHHWjaVJaduIuzTX1i8khoKzhhJBENnXIYMgCeeM
         tzmQoVpy4mtesiyNQ/DqJOF30BqQ/v3PS3QNkVNdXNwBsp7zTjcXGBugGS27JmW/nYCn
         Xdr/0QHX+G3WqEUGGyl3DeUK9/Or1BiOBR9jOHF+nEVD725OEU4jJeWCgi/mss3zpuG1
         FBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952030; x=1775556830;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T6EIlvZH3JF5hnFE4p0T/H/kTlcD6UcTMySHi2XMMo=;
        b=GqJkTqY2wZC2OdDJcS+F+7IE9IZuddmSvW3ow/qL/LhFoTyH9nSfgC2Mf4y+sdiaTk
         CgZoSVQHznv5JHR2H8fLPJ2jBO5vqBXyjDn0VNa3b5yIbGnC/iUz8Ex9YnFR5+JEj05i
         zsvTa0Pgz3vfbskyyqfbRwqhzDhbMNsGmZFtiUKMwSRyiKWnxaEvXNuqSxvUV3xQAyIp
         fPJ30ygRr8SrySFNWUMJdZXvvpmKpu6EdVY9JrhvagYBfw59LTebSZq5B1c+Mvn2Ury7
         xrNlTNZb/HhoO2BoamllESwgNigoMq5Iafw9jDT/8ru1G452i1k/nOlKK1EJlzOyUdpI
         R7iw==
X-Gm-Message-State: AOJu0Yz6vNB0tbFSO5oxXQAkLrZbPEyyJ4im3RAZyfEg7vUGZcq13r17
	mOBj5GmfTyemtJpaqyV2tHbb6Hq4Pw4zDTpKAZRDGy64YpQajpQptS8wqCGK
X-Gm-Gg: ATEYQzzKAd4QBBL7q7rsbIx93sKwf55gIr3mYUQUJeQy+4npg4PlRF7i1dxYJ/PcvUZ
	iUCsOyf8UIILmL4Nkk2qXuWFCzLWWzx9iTqk2YI+nfef4Z6ZyLHQux1X5VUTkfhYrnUqdb3WT+x
	tPyQUOCn+tT5Lsh0qgJkKD4f7jVC9YZfwWf4ocmjmFX165unpHRj+Ie0W2j6Tox/In3OYJT1LXZ
	ilB85nmTTU0A3NGVm3GSWKdkDSOxY7l3XCEGLa4s40DEpFPJthaJlO8JKElWDTf37c+P14ClWWp
	Vx7cLi9WDCX1jz+0X05xmYja/G02uQMKAyRTP1h0Pz0jevD/7bkoOQDJ75ayDPlenihZeVHZn+I
	qbLBsOklzU/g3cE4nMJVP0MFkG7VH8LsNVI2Z06rKBNXGo61hor2cchRNpSVz+RPJ/ENBnFjk1C
	O9YrQdhzsFexsQCYQYG56bmMy1zBMiKToMITo=
X-Received: by 2002:a05:620a:4450:b0:8cd:e162:1ea3 with SMTP id af79cd13be357-8d01c7e32demr2157347985a.58.1774952029534;
        Tue, 31 Mar 2026 03:13:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028095097sm836390985a.46.2026.03.31.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:13:48 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7d66c0d1f1384b142b064a760545ee6e2a8bcbde.1774946177.git.tanggeliang@kylinos.cn>
References:
 <7d66c0d1f1384b142b064a760545ee6e2a8bcbde.1774946177.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] tcp: add recv_should_stop helper
Message-ID: <b319ad24-cd00-8217-08af-f8539b403aa9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Mar 2026 10:13:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/237891=
10560

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/94bd185c6c6f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1075047


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
