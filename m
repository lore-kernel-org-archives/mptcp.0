Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48A18E0C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944676; cv=none; b=trXqbczGmU429POz4RGdZVLby4myZXvKmizx0mzebsmsbNRdf2t2i++seGnZExB65GwoiAgIDs/zjX2VUwAVfILetlGknntVNEjfL1sXcJiayG4KJh3DiJ9moqgl0xy42sgawdwbX+Y+Nrt2EAGhr16Osa9hHwee91dGoBqiv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944676; c=relaxed/simple;
	bh=kAAHeCKQUjnCUhWxBAP8XHgo3Q/jiSNH5DXvLCLDNYM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fSsxnxBUsWVjF1qLSUJ2CGQiu/Iu050XCfeouD4vp6GVNr7qnh1bn7cLcxcQ8Pl6opf6ORLmx2VNbZFW9fyEgQR4YhAtABJqcGalzFKt7784tY66FWvo9jYCgNRTTTIPD73ktGdElUV7+1wjOpjPRCaPHch1Qz62zNxAvO/G/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvzTZFOF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvzTZFOF"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68f111b9d92so1348546d6.1
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707944674; x=1708549474; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fptfd5RfSKO0mHIGgxB5VvtUGr7pI5lolcr6aAP9J0=;
        b=WvzTZFOFuvhsJNYDQXRWUSiHlmZdEIWTf/MzJ6E1WoKjaKj/coCqERTgrT4tXMictH
         VnRHx6p43OBdBN/SoD14vmP/vm8pZ41oPJ9iLpNC6ZMyVadG9ataSkRBWumLwm4UNI8+
         GnmmNa843tk/4v7DkUG94jj9J79Dr8oEGsWxJdXRK7reazSL8x47UfjZqSARWrXr3lXh
         ak+YiSs2aEYh1KByKi4ku6dUvjxFZG4r12T0BpAMMwOjxaH6MGlAMv9OijV8ogRs57xL
         5XeZqWvx7t5PLuphLl5JJF5jPuUIpXVBI0eA5HrAvX8mH1y/LuwTYmnrd2jAycwzwIph
         dXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944674; x=1708549474;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Fptfd5RfSKO0mHIGgxB5VvtUGr7pI5lolcr6aAP9J0=;
        b=kBVIi5uxq6T2hSgFw9oWrBl4z7sAXtbKcBvLffJ5GQJj7P5oUZ28K1hJyL4Un/88E1
         VP063DP7Db1G+nhp6QyR2EAYswHVknNS5TLrOD44gfM16RXI/rRMrx7eYhwdp59+Aktg
         YqkxwhWUpXF6eRU+cQB1F76/Y64SwepFNy4wpcOmnZ4h6sofrBaKlpDnhaQxWMOwpfzk
         WAEI7QVAWJvX0gXPpevI6cA3U970+6m438anJQbuyFK+y6RmqaNk+YyoKcd5aTV+cHf1
         RLA5+sIrZN0y9wydTnu6hXcXFMA2GUGVFpAnYx3Hs5Fp0fxPP67LG6NsSg8q1AJzHs6C
         rb1A==
X-Gm-Message-State: AOJu0Yyw5aT/SlznNhR0FKDWd7K0hayVRkXE+iDd7k5PW7F3zP5GxFXg
	4owEPe/KQ+VUZgcFjwcjFPIDyeGD8hAixnnZqgJT3OQkru9UmEs=
X-Google-Smtp-Source: AGHT+IGs9zCY9y/rU77wihVOfcRGG250nsps2K6C3sLP+0ZTySm56hTkOP/EU8LLj7MH6i2WNDprSw==
X-Received: by 2002:a0c:da8d:0:b0:68c:bf47:a7b7 with SMTP id z13-20020a0cda8d000000b0068cbf47a7b7mr4178135qvj.12.1707944674383;
        Wed, 14 Feb 2024 13:04:34 -0800 (PST)
Received: from [127.0.0.1] ([172.183.121.84])
        by smtp.gmail.com with ESMTPSA id ly9-20020a0562145c0900b0068c510634d1sm2607296qvb.108.2024.02.14.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:04:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <1e7668be-afe7-8437-2737-a25fb06ca4e4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 21:04:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5986065517903872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5986065517903872/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5423115564482560
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5423115564482560/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a36a5e8538ed


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
