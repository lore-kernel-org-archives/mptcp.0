Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B71101C1
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902051; cv=none; b=noiy5l2snf9Bh3p6T/SlAFdGCdGE2V0f5RguPFlq1VBFOn1w/9Wnx7BEfT8sY7EHGbfDHZMU0NoDMVL9dQmjHc0QRpQPe3LA3Gn/2h7hhJ5LWtKSP0w54ov4tGLpVyBmn4iorMLGQkv2G9PaMadKU815N9ulFTzudpcygEPA89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902051; c=relaxed/simple;
	bh=PsXva82WYjtUxyVuxcWQ0B8dh+uDRPBwkg9Y2RouOYk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Q6Jf+h62Ptr33I76UGii1QZpO2Dkc3mIO/D5F2FSSC320MYVM+rU7hZ1BrMrl0KErpEfyAreuaPv7DDJoJ7YUtsriTpmbXCPHs6/RvexqOCsdviXBVkKn7ukfsyJWTIDrdeD9H922d9qJcEdm/+Yr9gJ0tnOXq2XWg92aDfvbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ6zMTeG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6zMTeG"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60778cd55caso19990207b3.1
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707902049; x=1708506849; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuWPy3vKJzAI4maJSCrVqfXbeBI4RLnKM6Gkhl304aE=;
        b=dJ6zMTeG0wndmM+JZogJkGN6hUiP4S1H5S8PnerQ29ufZ7n4N51mIqQ8A7zFQrsJgn
         5mvFiHz3NNgJhGK4Pmme+Ch8dJiUmBHGeiOS4JD7a6Uth2AY5GJB9/AcvpJdreZRcJqQ
         RTW42a/1Bzj6eBIP55jtSYE7n1OqPmhgUwC9Ghf+AZg0ogCRxzQB8XMWv0cxS6rsyI1H
         SXg7e005UmPHnJ8n7+YHAILBzIurfrZbh1z7+guhjX2hv+rzYZWQyfMI+eVFCCsVuHBC
         keaYdM5terTI+1oVIJKetczpDUiNKh2ky/Olx0/C/IrWgnxM4gMo165GTvmq8uF0fQF5
         qhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902049; x=1708506849;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuWPy3vKJzAI4maJSCrVqfXbeBI4RLnKM6Gkhl304aE=;
        b=neE+hJI7dNkTGh6j9ef+/VgqOUG0eUcfyB2FiTDR7piZ7sOlC/j53xJtYjAMF1JXtt
         6yWzY3BiMXZsrHQ/mRHYtQ6fuJcl6ijrdWMsbUf82zHN+ejtgCplOSlJlrENm0ERbLQk
         uyTTMEET7iLA+JB4jEphdlSy68zViX5U/N6jtqGeSO7EIjqog/VlGytNz+SIfGIO3FwR
         YBwwCteB1x93XkMbzRQslbhR+uSErL1xwXfaQ2Neb3IXMhP9U/ghbAr+nqECeBQexX2E
         K59BywMdSd6lShkVHN1FJfBtd9m5RJGnxj1OTklKl9WWXwFn4/ySjDYf9QggBxuij7md
         O1Rw==
X-Gm-Message-State: AOJu0Ywrzx3xFfE+dhSWsVEUUR3fKTq1XkPKEpB/P2NUpSVDwIKFIXZJ
	SjdWzRG2LM0xT7gF5c+Opvf+nULiVF2YK0UPHbzKDAsgrMxol/M=
X-Google-Smtp-Source: AGHT+IG1ey2FcsPXFO7hQAAyylLv7TCFLuXjHu7Rc8/TfMLcQxmQLuY9weRuoTtkgllFBwbor4eV/g==
X-Received: by 2002:a0d:e806:0:b0:604:9f75:930d with SMTP id r6-20020a0de806000000b006049f75930dmr1954740ywe.18.1707902049100;
        Wed, 14 Feb 2024 01:14:09 -0800 (PST)
Received: from [127.0.0.1] ([20.49.54.4])
        by smtp.gmail.com with ESMTPSA id jd24-20020a05622a719800b0042daffe1891sm1122322qtb.65.2024.02.14.01.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:14:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
References: <20240213223135.85957-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <f5905a0d-b1b2-9cc4-cbf0-169d97513bb1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 09:14:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7898465398

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fbdc306e8139


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
