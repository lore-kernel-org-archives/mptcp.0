Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8F1C5D59
	for <mptcp@lists.linux.dev>; Mon, 19 May 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652546; cv=none; b=Zt61r8tjYpM0iWlGUF+/+ec8LD840Uxj/oQzxLFCLijaA9N4MunXuaAHrBX868ycIK5Z257AVa+YWplDz9GZkyT2Z4+KLU2MGl6+jVCAknteQuSGzylVl+mHMghDFdDbmSdBAb6KYVr/I/TVdAaaEqrQu8mw08Wou+sFpmTNrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652546; c=relaxed/simple;
	bh=NaLo9cCoYKTvLgtInonA4YyJ31j32NuhOrjNWTU/4jc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=npxzw5sCOE9nzWn5vF0TIT5ivqhshf4q2UIJkvkQp2LpvIpiEqVXFxUpKC3IVVJF2Xy/regohETdGNtB0qGPZS7sf1NCxtcaDKQpb42YFa1RgxcGH19UySvzryVo8Me5zilOpuMSGKhY0O2XWqVx0UA8X115fBs1trELgNC7w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=iG8o2JuI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="iG8o2JuI"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-601ab204085so2701749a12.1
        for <mptcp@lists.linux.dev>; Mon, 19 May 2025 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747652543; x=1748257343; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NaLo9cCoYKTvLgtInonA4YyJ31j32NuhOrjNWTU/4jc=;
        b=iG8o2JuIMH+77rNNzyTcGFIH4BylZM2pD6RL/DymboCwyBXmREBLBqqIKzP8iqaaLD
         U+9Bi4jQ3qGwUszWvGlK0/c9z22fOK1UaAtVHSqrfwTQwmGnlCY/cF0gn6+pAmCQFGi7
         Nbgl1AVxTk827Sk+5SEKgtM9ub71IsGpEmmnqk2xbFd+WTcUQV/NRTa5kNRSoUBtcLc8
         I+ussKE6QJ7HxIQeEdJUCE42kUg4WPePlf0KfC0quWL0S1fOrkev6Pj9U6NAo14rKKTi
         CjmgcrtTqNJ3e5k+eBGldmPZ4G72eapQdQ7TU4vtBVdXmD45luxMU+aZuvqjeIMoVa5d
         AxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747652543; x=1748257343;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaLo9cCoYKTvLgtInonA4YyJ31j32NuhOrjNWTU/4jc=;
        b=TauCaHLix8l9oDOmF6sNDgRWGmFdFYQvrsMmcDUM8YqoDPhml+/KhIsp5yssIGof8t
         6XriQ/BiQgUUSVlmNUSk4s2/XPOACzwDAXB1/vb4HLVOwiOuDFsqHcEB1QI8RnBLpACL
         aSj5+0KqfTRRbotxd4wAjaXoc+Px30IAarPcI8JArRQhjKgmpuscRYvvMBQ7kqMi6bAZ
         Pr8an6sp0isIv+ehEtPThZuGZoe2prz7CkUW5cBT9mZA4423ci47K5/Gbj4e/7WF7MZX
         oZpdnECX7ADEnPN0vu9OFrugnEsjrPhTTwqW5XLVlQzsXXHZ9POsW8KsE5UW/OPuDHbs
         tr2A==
X-Gm-Message-State: AOJu0YzCeCsYXe4kz00t+7kMlRcTmmJuUozBs0TwV1BjLh1XsHRNb+hy
	yvqO/6jILSgiaVfLWvuZo/zsPfhet0h0Co8f+6w0JRc1sHuW6Xd0rq3vELduPPJx0CMrDGA0o8J
	yJhlu6oLDjXxyNTAjYo2Qsi/RfLNQTcf7+2jplHTO1lNxGtrbjMwmBmA=
X-Gm-Gg: ASbGncvPRYU9yLTJEAoEyBk8ca2OZ+4wYOCqDkra/o+jAdBcz8/lTQWAf61frCjYyvE
	Ct77KnIDeBs/HN78Gp1dpyK2zfLep55HYunXzofCy3bvNbDOZ+vkNR0l41sSMIJL2qtshbaNQek
	QJByqPju7dSYbVTa803mIZxM3qdx9lISpDheZ/yoDpVnYeCV5+NcVQ6nY6y9rKJdybw0OwDTHpw
	aCoCw==
X-Google-Smtp-Source: AGHT+IHPm0XjpaDfvQYG/T/1KG8XZgZJjqqaRYX0b93FXwRE15JLGlC9QI/qCiDbDVzt1vO+Gr9xqIGjJU7lqSwCjCs=
X-Received: by 2002:a17:906:9fd2:b0:ad5:2d5d:2069 with SMTP id
 a640c23a62f3a-ad52f84b51emr998345966b.13.1747652542777; Mon, 19 May 2025
 04:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Date: Mon, 19 May 2025 19:02:11 +0800
X-Gm-Features: AX0GCFvHafepX0btae2ssMkNTgh3ipbDasopBbod069pDoVxhnu0RyErLKEB020
Message-ID: <CACNYkD4fBm6FDDUNbBY7Uc3MkONF7A7UDNajkTP4Xc4nfvWXZw@mail.gmail.com>
Subject: MPTCP support for git (on Linux)
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I don't know matt's email address so i am reaching out here.

I have currently added support for the git protocol (not git over ssh
or git over http) and you can find the patch here:

https://lore.kernel.org/git/4A7FWS.KARM6LOQBQ5S3@unrealasia.net/T/#m43718b0ad86f1f70b425a913dde63a09ff56b758

Reason being was that i was handling large (public) git codebase over
unstable links and i think it's also a good idea for me to add for the
support for the most basic git protocol for read access of large
public git codebases.

The implementation i did is for both client side and server side of
the git protocol.

Regards,
Zaihan
