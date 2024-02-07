Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034E127B45
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707335800; cv=none; b=c8vqFTEqU3uB2g41EHTleV6zV//7A0WqIkMho76KL3Ob94Cv9/H3iVjEvRNyu2EcOT3gWjdRAc87lVXATz3/WVb8AovTua7qM+v1nKlYbBCJr5dGt+Q8PqantgoeouR3bieggGXK6GqUM97JsZgLHCacoKB7kFhHP0QDd4h7LgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707335800; c=relaxed/simple;
	bh=hnH7seXd5EjLQjGNdt3hpM0K6m2CJB1m0JfXLIzy4Wo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ju5uGVL21vCOdFotxapErZ12SaIc+QlzH/YFLaKUNaxbd7Gsv1YgVwaxduwXeiz04iRKVgiAAr0mpOBrQRR5VCamrAF7rguQ9s5J/0Dj2l275u+zU7G7oxci2isV8mMg9Hmiga7CqlDIsPW9pv57Ji5uHbI66l1vKQ+yEDCaD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSencA44; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSencA44"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78405c9a152so65148585a.1
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335797; x=1707940597; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpsSchpge/s10EidBP0niZPtYidrfFrPwP+pVC500wM=;
        b=TSencA44oYLgyF/zqMaWeMKtxVPCh3VDa4wvt3vYUOJ5Z9U79Q7yS7gvItrxxhE1+P
         7mg8t6DhYX9FE6hQaSAyOF28OOlm/lm5cI1OeZ6JnupwQ//TQ28n2ZEnGeJY40epIeJb
         83E75b58saFdTe7Oui/4L8eHIhX9ZCCEDO/Dco5cRmoB/xxRmUngWsYJPEBrh5y01lIV
         j88ZXIGNi3SgKSEKqdQkX+IRx+TzJzaz44inNtiVKyOakl+ZqqgvnrOe9ILWErMmAyJl
         ZFEw1pjaPH6mqc3D7jFYNxxTN1l1MbCzv5bWvHPN1AFJZ4762tgg+zNjfJoGbit23ufr
         OYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335797; x=1707940597;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpsSchpge/s10EidBP0niZPtYidrfFrPwP+pVC500wM=;
        b=B30NWD6p0/xicBC2PDJ2utICf3uDSVij76rzoDMV6wahuwdndjSWAKNk7haOL+IjmM
         RXv4LAtn+UzSpCljCTDz8Stta6jVizaillyJFD/4Lp61SfDXrPQyC0mSDCm2KzITs2yP
         mUgKbBuiVRLwAA7JrthpcwF4ewEt4sN47ViSVQZojHskn3e+ByM8Sj6mnLbKnxeeKJvz
         +2FjwmFsx8Db8k/P9RePJKflt6Mvq1vOxPtPYFvCmHiIfSzcLbH7PQn41kxiHuiMvKWC
         5ilnevOZ6qET96C3aL5+nR8j+jDp2PQzCCCr/n8Eu8Aeksrq8IHviXrokz2Obud/IN5M
         7WpA==
X-Gm-Message-State: AOJu0YwDKA4OkCo5vgU4c1WzGHCMXjz2WrtD+WKxJIv2r0jhsw82aH1p
	KTliNKfvChjzpLeKzJBCOdKsijwPBrsHATIW0eBEUruQ4ZVOHyevs4WKR4M=
X-Google-Smtp-Source: AGHT+IHypfjDFglHKj+fhZGOuIkzVVMu1UKbIZ6yfgp1+s9Z533l3GUMQlbTKb3PBFLzyfVdk2D3wA==
X-Received: by 2002:a05:6214:2424:b0:68c:ae6d:295c with SMTP id gy4-20020a056214242400b0068cae6d295cmr9160304qvb.0.1707335797411;
        Wed, 07 Feb 2024 11:56:37 -0800 (PST)
Received: from [127.0.0.1] ([20.42.106.67])
        by smtp.gmail.com with ESMTPSA id dw6-20020a0562140a0600b0068c80f69ce8sm869454qvb.142.2024.02.07.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:56:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
References:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Subject: Re: selftests: mptcp: stop forcing iptables-legacy: Tests Results
Message-ID: <c82879bb-dc5f-d921-365d-0195bd416c6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 19:56:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6418879304433664
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6418879304433664/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5527929375948800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5527929375948800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4f8d1ad0ee1a


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
