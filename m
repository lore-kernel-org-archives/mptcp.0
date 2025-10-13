Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B762475CF
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356241; cv=none; b=svV9kqcEaykImLganfM3S29HAA320Wt0nx0t/q3QSzY6tqcTwWi9/amOSCRLzPxlAYRH/OaPV+JCUcskhpE3rvq6b7YUiVG33ARpWlSAVzMrxGFREM9ddciOH18e6Ip6NyYrzi5OsGAoyh0jslPMZBj2tcdPzgOi56mbkdn+XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356241; c=relaxed/simple;
	bh=2/4MoYCB406bSqNHTSiUYPHGoMDDboVolBgXO7QsKQE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ONyF+W1/dLwhI6vkNCcvaOMo0Q+rw4oV3mJzHvPE+jCWMuF9v4UPxvOTbSoWCsgMv9I/SRQHDN7Ybtpph1lMCtEZeupVvMXtVK09MfJ2uUYfpyAarFxGldyUYob4/TF20Ps4BnsLqD+7C7AWwif2kxdxZ3Ufhrr54oMvRq9uzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKI1VX++; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKI1VX++"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811fa91774so3494249b3a.0
        for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760356240; x=1760961040; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJJ9sl8uF02juag+vslCbuEyqXuVz15c/ASgNi2O1HM=;
        b=PKI1VX+++ZPFB8YFJZfxXJ0St8xP52lzcXAZAYEIU4Hq3TdDbVpkl91Sd65cjGI2uQ
         79D3jF3kp2hCCFmbFnSF6pBoZMZvsEIUKrezTNnigwXHTkhDvSHi8SYEV10uI23kNBOf
         3A92apuZIre/jaimM8gK7SDBqhL8XqzTJOp2xFX8owGNi63Prx/cAW/XMuiVgR4qkKjN
         xVqOnUpJbfPYwB7xKDBVZIOyHdOzd0LnftZtMoDJzZ9XNKGkz3/usVKsAwWQcUBOGGbj
         jzp1KLKU7f04MMqohh08gIZkJEsvqsEd4ZGa65yrjYcCZiWZtWQGLLdjl0wLfE+Fd3a2
         iFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356240; x=1760961040;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QJJ9sl8uF02juag+vslCbuEyqXuVz15c/ASgNi2O1HM=;
        b=hAgmt7Xx7HjzDjJ3KVeCzL5gmjbuXlzt/UiR7M8gHP2nYBefPk9pxu8VnMxmbzVz7C
         sT+lFtu/Oo473G588u4KP9/wYmGJJN9VKIX0/lHV8Wy6Nfm+AFEgTIyl21Glv+28+xxO
         dCqrAmTrs4zFC3BuY0ixRHf2Hg/OaaIBD8HvENSHxJBJSjIFEGRujSw/ij5EYIPGj6Lr
         UvwDSdHien5FO/bWfJa0WaU7gUuHODcVs/felSG2HSwtqPeVilB3oI7PO2R7H+ZXfTZu
         UtOgO95KLtLcfkMHJFYhos1tJBAmlsJVSbhAtstjje44kD74wlMLiM0M87onX01f9w71
         BnuQ==
X-Gm-Message-State: AOJu0YyyPPxtu3PiHswEpzrkEpudxujbx/OP5ywTXlLyP6C2jpljLm+1
	kAUChixmwoowlUVF7qQApEmDwOBcotSjL8n/RqbLSsfTVgNSEGsdnimLfURh
X-Gm-Gg: ASbGncvj0z5d7cbB9xZ3zykVFYGyg3AgD8IW1CtLFzIOodU6tf4z25zcwmyZ9QtanbW
	7sr7dha/l79FFrIJ/qj9GaeErL0q58FP2JkoEbecvZllpe/BTJCRwIxy2RCSi5HQnNlhaABZa7G
	Vm54tX8oja36KQ70P2UIWE6sDxoJYH8ZtOObXhlUscqeKD5fH3mEkedn+60YW8JFX76ciaogBc1
	NLBEajOGE9t4btL7zQgkI/W3ID58asR0kJmbQWA3+tR3bUAowLfcjOFfo5FJzVaRqgqiMo8d8kp
	6S+EfJo3kG7SinbS6/HHsAYoYyl3miHKAxbbWFpZ/mJBzzmiYJY+Oj5/+DJhM2ZQVFO447Wov1w
	w3KrrT6Z6YVH8Zt2EoYmawrSBsso4m2FNwC3Ud00GKz5D6+iPQ6KA/xHiVgt3gANVE/U=
X-Google-Smtp-Source: AGHT+IHtfYQE+UHlZladfakyjBjBxvTePmQBaLoxW48I/+sMEKwscHqPWJ8/RC3Qu5UawGy5b39kLw==
X-Received: by 2002:a05:6a20:3d1c:b0:24b:1a6d:298b with SMTP id adf61e73a8af0-32da84630b0mr27231777637.34.1760356239625;
        Mon, 13 Oct 2025 04:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.213.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df4cb51sm9006319a12.30.2025.10.13.04.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:50:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251013101946.248420-1-yangang@kylinos.cn>
References: <20251013101946.248420-1-yangang@kylinos.cn>
Subject: Re: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Message-ID: <b760f349-b2a2-2259-7038-ef101aaa0642@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Oct 2025 11:50:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_fastclose selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Script error! =E2=9D=93
- KVM Validation: btf-debug (only bpftest_all): Script error! =E2=9D=93
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/184631=
51285

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ca9d5aad6b72
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1010664


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
