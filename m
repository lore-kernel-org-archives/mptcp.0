Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15212C7F6
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818903; cv=none; b=k0KKX/WHlKUrWRz8mJOc0RlXzsnF6t1H0qC2xjHxHop/CzZmsHGPpXyRRZO1Ro4d3AAa1BGa7gDpQ520EMKr0mFpulzAOgdfhmHuVwdrA8tpKaro7i5TXu0oyCZpebl825GPRswEJC9NpjknbZ/dYTP7GteLqKnt/LLfqhygjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818903; c=relaxed/simple;
	bh=IHVJSJkEoki2COj/Cn1m5e01Nkh7cMECtqknW/8SuE4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UTkzYUjIlvDOOQIBsqIC4N73yKry+qTqFRzbb4p5QKQUkl79BPXRTU63CryaVX7PF1fgPZfaXxcz1htm0GPeeWT6VEof2hPQCuT9ZEp5lpc/894DpdcQbEXxzB9T8zaKFzhBoFLyWMK4uoL6IvAejcdc7OBv9YeJh/dKO8brHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anevCQBh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anevCQBh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so7507325ad.3
        for <mptcp@lists.linux.dev>; Thu, 07 Mar 2024 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818902; x=1710423702; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0PLMCeQQwsYiebVTEDyha8GAk70PHFg3WXrGiIppjc=;
        b=anevCQBhKsO7iqGZigyMjlAbWC5MEe4x0FM8Z+J8glSq6OWwcdTr3VuQ973ydBuMO9
         3E5VTrdcm7+cZvw15Bt+GeySzlLH3zQAIvBdHzSWwBlyvmX9FGZE6ZmVyxtvjvP7N+7P
         JA6rR76xVTQ5t5O0fRpmFnM043iadRXWXt0AO5frqK3yRXQJbhO2z0T+ayRhe612V0cv
         TPj/B10v+tt8FVq8xJtQmZ/xyYy4lI7RgN3aByJrZpVJTYvjP+zoDGEouCEe6I9J90J/
         5osUF4UyvCZMMgVv8VLF/NCARy/6tWtLtZMCqANK0aOUtCBT+jI+NQh9KhH6E3bKoAgG
         sPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818902; x=1710423702;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0PLMCeQQwsYiebVTEDyha8GAk70PHFg3WXrGiIppjc=;
        b=XhXpyYFPMxrw5nyYlqBAOznxpiCvLttsqpUX7q75k6+mXEO7nY4vKQY8dvzh4L9iR0
         7g03unjd2RLUeAJu+pXEr/cMyOMS5vOMFZr7T7eJCdXALLqO0D5W34PUni0s/mqNKhaP
         O43++DIWXKCTbBFlU/fKDAVhlARxNJV2GscLTvE0+3E1qIDUpBYOCqAPXxKihVnUC6lm
         CQ7I610rcemzXIDvb9WaeZVQQxaq+CA7Xg/QQWYxmSYq5MScd/GcOXdlXnGPYFygZISf
         6UMH93pLyhXbdgiG9puyQB0FtMxn4O/C59Ttx9yZUqycXjcMIDtskbpgeWNcL2iHbEGM
         IapQ==
X-Gm-Message-State: AOJu0YxDPjiRCAYklyIt/zf4lOxoRHLPyFZPVhN5nzmGNQtrtFgQjT2r
	/p7HWB3iGY7sZv9BjS7ZfSy7Cil/8ShleE2e74csweJh3uy+hugcFvI+hD8=
X-Google-Smtp-Source: AGHT+IHQjbKa3wMg2YmYr7xEgAPR8tr2Z7KRPVk5se9TcVmTJRVh4FfNI3KAnNELDKchZsOSV3TP5w==
X-Received: by 2002:a17:902:e88b:b0:1db:d811:732a with SMTP id w11-20020a170902e88b00b001dbd811732amr8163309plg.37.1709818901854;
        Thu, 07 Mar 2024 05:41:41 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.8])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b001dcdf24e32csm14193799pln.111.2024.03.07.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:41:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
References:
 <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: join: use += operator to append strings:
 Tests Results
Message-ID: <4ef687a9-6181-a332-4f5b-1c0bcd94a0b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 13:41:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8188604631

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/43ce1abbfb36


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
