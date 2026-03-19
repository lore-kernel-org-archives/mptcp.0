Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B9364E8B
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923248; cv=none; b=ay+z41I55sOku6bNk2qxy7SISVZ0WFf9ED4WYHfcDduTEliR9uSWgJllwP3z9YEuamhe5tEvk1kRcPZ7ceNOLRS4h6irEurcRY0bHDLIbG53zcLK6PmgNxxGXXlG0XyfMaDnwNP0s2BVSIWbSRUvvND/zQrTtM2kcNIfEfVjY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923248; c=relaxed/simple;
	bh=9+li7O/15UhlQAAFZqcDjRgqA5KInmn03xSESA4egs0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dvg0h1R0sEyFEv1HrknJTPzv82Al13BQDOhHnUkY6nBbez6FRr5ClsxEBAy21nMqPiHZJ8PCd6rcXFpGMd6/TZzEQovb9L872B/y8hwkHF9mP5aPxF2TnFyWMw8rK/TMw0TBG5Vw0Akclu8HJk2ZR8w8Pq6jDuyh0BtpItF3+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gku3WDSe; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gku3WDSe"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12776bebe9fso45002c88.1
        for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923246; x=1774528046; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6OAZPPL47TwLIqV0QlTnH6cIOgNK8+I3zGZ/IXFJGY=;
        b=gku3WDSe+P/sCXeosiV3Ryw5OPAobnjw/tE5D5s9s4qGUCZrDBoAqIWpUa8Nf9RJec
         PppndleIFGPeqDbrnBg31PW1vxX3wFhklath/Mo1GPuldWdSLx9OVDTHfexBQcc9uKsi
         cdpCR/CMHFIeQ6Dy8ZRpJtHgKjziiXGrc2YGtSiwkvOoAltStg6gzahd21ikNvIQTZf/
         w/p1EuanET0kmHmkuf4gC3AKOmUs5mWg8h1GKBcYbGQZS81/7APtl4f1uyzR4RQiWPCq
         Go7bLErWdvbNQqq94V0+VTT5Mmp/0Ncb6mqQB9j3et5f99rTa1vIuM+xxAEiMNvHi5e0
         RUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923246; x=1774528046;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6OAZPPL47TwLIqV0QlTnH6cIOgNK8+I3zGZ/IXFJGY=;
        b=KkDuSI267NSNzuUqAhdWG2NdoEEfhvYlZe3H7zG2fR7TTUevr/yZC9nOJn4RK5ITlw
         o0e+6MSubxbaseQ3ZDhltW+izTiDgFu+8wKOOUjones3Urg8tYGNIiHbo6sG8MGZ+jXN
         c0f8W9ujap5eD2aedwYWtq1OX9GFQs4JvS6OHRCwIocrIA7f7V8mOMbn4tCLaSaSDMD1
         o6tGsqtDcp29UjA75eZLoqkGFJU4ZP7QfXKS/pXOfyewS0z8D26BIeLAPLk15x80kp5K
         meka/nLdY17Mxaqg48V0pYHMz0FN5xusUj2GU3Ev3U3rQEpKZN9/dPH9q/i9Cm2nJai1
         VX+w==
X-Gm-Message-State: AOJu0YwnTWeknvlGb98qcQ6jfPDUY93ivy2Llr8fv4tAvtBDyXE0usnX
	Y0BZlR4pDE+DHLIoYYQN8eXwC4h2OgowL2JnhkjWU428r0AnetfStdomzuAg
X-Gm-Gg: ATEYQzyXgvGlUhCYae/YzYnAY/tvC+BOS2AeEC/GvM5MygXK7LMp773U8LMlZ4InjfJ
	8E96KKivSz6KQFne64MRJAWVfFL0uzo7ky35TxJmaMFzojMAQVcEYX40YFjc8u4C67yIrg89xR9
	SMoa3GvryKV77qCeqmOeLC0MRRIzRC/JpVwKN3pIWIAcvKSTxq0B8YTT5bp7p5sOHxchSTecDpG
	R4kaY6ffQCNlpnCMekifIlu/6gSkuLzjZ0Pbo6Nonlj37MLtVey29RYEQcXRZINf+Zwxv0VsptR
	BcRYM/Zaj3jSql8sU91hKj/w1Fi+U3mqRBWOfKICmpEfUwwDdSJY0sgDx+ybzUJQ67MwDvCie3g
	Q1Nc/sj4mJKZDEZguk/ZWqOjhfUg3brdr/RunJsC30dhWZR9nO41+X1dcOIK7OfU8f1qRzyZjQ5
	PO9vN9zqW7SSPxcLjn17kCjrDOQbSd+1KXXMBby0MtpyJxdA==
X-Received: by 2002:a05:7022:68e:b0:128:d967:4674 with SMTP id a92af1059eb24-129a7160559mr3620497c88.19.1773923246023;
        Thu, 19 Mar 2026 05:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.74.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a6b5f7ec0sm1523181c88.8.2026.03.19.05.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:27:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v11 00/15] MPTCP KTLS support
Message-ID: <ae1f6a10-0097-140b-d4e9-5a9fbd478d07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2026 12:27:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/232907=
12003

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2e6e6160b271
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1069182


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
