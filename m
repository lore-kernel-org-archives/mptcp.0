Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A54266D4
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089651; cv=none; b=ZcsT+KPwKBU3OzIzfbTMc76FLRBgLAEj3Dsv8SeN2BWV41C/gotYaA6aNLqFycBsIZ0Er+9344h+78oTOfZc7zH2tC1jAM8Ww+GZfRkbW/hyJR+69TMCynm8OvFw6b64woUZ8QNbvfqvEfLOTVrsBVTqR9G+qK26oN1BTo2hU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089651; c=relaxed/simple;
	bh=mi60pdtqiXtY93iigrISmhcnodSCf9j9fahOxPGFeSM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sh9EnfqBPy6FfEwBnmINfOBPGEBrYxEAuh5/K/MZlSa2r7iCmA7xI7dt1tqVBsxT3XcSzden/x6F5jl9zmehQ7MxNZl8Bcsu7LrWzmHMFZMPk9N0hTFaLJbv+oJMNOLf/oTAEqNVpoAikFiaN1KRhfJGMIvSu3gkbXnEb1JdO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmYJVio3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmYJVio3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818f3cf006so10625126d6.2
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 05:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708089649; x=1708694449; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwGjw/Sa1U3bWxMAMiyZSBWVRWPpsJs+EpT0lwsfbaw=;
        b=ZmYJVio3Cdp0Yn0CGbWmgLpBgKYY9aSZ5W4x//11uPYqEHyZMPcJ4tY3U+Eam69EH+
         Y7y6q6kUPbPPj14YscoC3/rsZeAowv5+mw4/OtCqmCgCNwWC0cjh7b5h6AvF67FDw+D3
         /FD0pwTCJgJYwdH6YxIWnYvuwztZh3yQHje993ENPzuZr30oLFMtdKMIANDaaJUapdBB
         DoolHOb9ZhwYrVbH0oXDydmLf5+PqTu0SxZxWeXxrbh4nwQPQuBMODbbkdVpEHYYhFxO
         yFu/Kq4w6CegnUxoz/TRqRiXjlXbQt2M6vYdErSU6Yoze+9vTTJG6HnntwHkIprVMTfm
         yAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089649; x=1708694449;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwGjw/Sa1U3bWxMAMiyZSBWVRWPpsJs+EpT0lwsfbaw=;
        b=JfFjp+BwJuJhMCijW3QeX76wWk1IAatDgsx/tFK/3OrRNxC7rcglOXXGs6AnWM5qi6
         AupP2vkNB5qWxcS6Ek9lG738N0wLwO/tp+WkRoPZrvtwu+K4gq45EgzQWPB3W63LmBUn
         aozZxlJdGcVDf5OG7QwBnKEuBYg+svYL4wxIqEtocojpa1cxt6y9zpL6+59qu9/XBJP5
         8tNWvJ/gq13Vw2raAXsM10dDvtXgrGWhaqnN8WLrR4Q9PeGRQw6qRj4bcJBdmZsaams5
         xmkX9z+22TGuSQ3JYfL0zmtLKGWVItbo3unN6UUx2QHwrIbXLrlM8gQUtcVx8Bfcv2fA
         wDPQ==
X-Gm-Message-State: AOJu0YzpIGpjzLOqcWWBnBCjH0vKK1MamMLSdts5dPG+r+ArnbTJWSJv
	565fLLQJP5lpU3b11obRIJzq1+YL3GEKbD+h115qQdVzu+/3pMc=
X-Google-Smtp-Source: AGHT+IH7ntDk6hB0U9u9PFl8PzbiW0+rRO6sn8ha2J76rw8Sl1e+VM8HMSiwvRQ6mVC8nIqaxt2w4g==
X-Received: by 2002:ad4:5c41:0:b0:68c:bf47:a7d1 with SMTP id a1-20020ad45c41000000b0068cbf47a7d1mr7316988qva.17.1708089648739;
        Fri, 16 Feb 2024 05:20:48 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.72])
        by smtp.gmail.com with ESMTPSA id v14-20020ad4528e000000b0068d039da1a8sm1706399qvr.104.2024.02.16.05.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:20:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
References:
 <20240216-mptcp-warn-bogus-pr-warn-v1-1-6388bf96adf9@kernel.org>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22DO-NOT-MERGE=3A_mptcp?=
 =?UTF-8?Q?=3A_improve_code_coverage_for_CI=22=3A_T?=
 =?UTF-8?Q?ests_Results?=
Message-ID: <5ac4eae7-9fef-148c-9abb-2eafeca098a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 13:20:47 +0000
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
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5311899533836288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5311899533836288/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6437799440678912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6437799440678912/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ff4697aba2c5


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
