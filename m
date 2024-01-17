Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F34685
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705463677; cv=none; b=Q4ggvti6Ep+jQXIPFlEUO3AASVNl7mypUvTRBE2sPlDLh7Pjx4JkVFQlprAkuqfFiAc6mHNZ/Uus6qRlVqftXJOazkzJ6uAkXq8p3RSzVuD/fVZUpmB2jhbj4VEwxIuJQibv80zXYPd+O5DVOxxtybVyJEoxQi79fDrMEwagINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705463677; c=relaxed/simple;
	bh=HEgczn6wutDtZZXrHqmV08Vv8ounTx7UNV/d5L/Oow8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=BW4SA2nfuWvnIyWMmZG7xbqzGll56K1cBOrWGkr8jrr2JPGyT/dER2VzUkLqE9nqk77NICPoKnPmOXyJ6Fe+YHd8kziEvnLKQrHR6/OB51j1HC1chBtHK/AnhERsh8CDNRJlz/NG2T+1zJIrm+VJ1/QU6TyCutjq0ygBxlfayGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj/l7htA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj/l7htA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-680fdf7d52fso68739836d6.3
        for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 19:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705463674; x=1706068474; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGXPQpXeaUyFK2Ih+N+9ZCHR/iwzL8G8fRZ3eE4YFgM=;
        b=Fj/l7htAJw1srjoPONaT6OD8HxzjwxhMinG5KSfZzpjQG12orD6Wjz7fvebm1PTDCw
         ny8md6b0k/YFmXpADOJjkblAWW1Hvds55ERtESu+7W/2mUjvBR2gCeLr0eTa33LeQruA
         bIwi2Gx9TS5AqoyW33/GRpNt/OfIB+xrq2VwOLy0e/Ja83v8sd1R7Nt8fk4lus/0Mi6F
         yXRAqWqVl/87ox0QhAyjNLAe8fOTU09dvYml2vyFKg5WUPScpsrdvo5czSv/L6/MSB3C
         Ks8njgQa7GJwp37WLik//RTBWSog8XhoN5chYZ+wy40aTeztj49ap2ys34mjyM6Csv5a
         jJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705463674; x=1706068474;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGXPQpXeaUyFK2Ih+N+9ZCHR/iwzL8G8fRZ3eE4YFgM=;
        b=KCciLkI47nAAvn1RSEMtg1xYPoKC2bziCHZAk6jqIq028Dey0X/YMqcKTSYE9tJhzi
         k+njErRFvrjJAY9vyPU13yAiQR5jcet1hOCkrnlUAt/nwftYiWM8ktR/E6Nc4M121SWm
         +ANGUILVui88mJlbiVHgimYewpC6NIyr7zKAIQiL4uIB20kOGSYa3sb1B6XOEAbJ86yE
         XA0+QoUsl3F66HyG3z+Bu4yhF6J1Y5X4TomHfQ9anodkvAP4U3pKxYJuslr1tZEGyQRR
         vziU/GlqjqSHBdDaHuKfMALMuLJHG2rNIfv9CMusyiCAkiEwNUY2tdSBM6uOPCUIqmvB
         99yw==
X-Gm-Message-State: AOJu0YwDCyM7Z3+lFC6yfQRc2RLpnF7x1cMp04g34FhHzG6wmK0kctik
	Xm1IMBn7x93iMc0q08MwA7O+30sPEBkq
X-Google-Smtp-Source: AGHT+IFUHDJmvhFJBgQpx4682mDm/sY/XcTw5v31GfNl+oxzJaU04I+4z8g8u7/Kjk75JoMkl4BSxA==
X-Received: by 2002:ad4:5e85:0:b0:67f:6ac:4bb8 with SMTP id jl5-20020ad45e85000000b0067f06ac4bb8mr9222353qvb.14.1705463674515;
        Tue, 16 Jan 2024 19:54:34 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.82])
        by smtp.gmail.com with ESMTPSA id j12-20020a056214032c00b0067f70fffc7bsm4720953qvu.2.2024.01.16.19.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:54:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
References:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
Subject: Re: mptcp: corner case locking for rx path fields initialization:
 Tests Results
Message-ID: <6c407359-0a7e-2a2c-3fe0-a1fc9f1ade0b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 03:54:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4675429135548416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4675429135548416/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5801329042391040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5801329042391040/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1fd81af266b7


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
