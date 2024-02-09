Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96515AF
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445145; cv=none; b=MFJwafntGfkEpEQWZ0F6f0V7dCNsSqnhoHL4SZZeEj17TLnNPQuRZ9jMLGrlaMyrrfZo6UvGhxW6ZAEguBK5wKLrzlxnXBdhA4wyNJozTosel7Zkg2meVhGbuBTozg/oGNXrep012qOk8t1RBjZlrOdFUGzW+oU1fTk03pq8jD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445145; c=relaxed/simple;
	bh=+9+L0PekE0KkWUyMonpQVuGFC2jbWO5KLdlQ/dfQsZ8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LP/fpF30+6MQZGXqiYMZT+bIePCI8vG7jnRlkxCKj9+XHnWWwv0sbs77xHoozj6v/+L0aQmf2SvVPuwaqiibDO8DRSMyXcwr7wzs2BmS7dGqfmPIdMf/ETAmk3jLXt6V86xglWe9fCea1GkZAX4fEWmcUvYK2JJvPbNJja2Er8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgi4GME1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgi4GME1"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so352678a12.0
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707445143; x=1708049943; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YRe6fwQoziV3zDsr1DVI/okGNuaRvDvH8YZwQd/sb4=;
        b=Zgi4GME1nZSPy1TlsSjGUAmZ/yVey+E9TmjoqcWotTuH2176Sw3t+sE2qO6DwVrfP2
         oUx03tUf1TklYUHUdAlc82CGRF3Ag0Nn3rA07cQW9Hd379enznWNdic1H9/uDyuQC/iz
         DKc+k5101z6F8JSRetU9T1w7VHPYNVvvqBWcfM+f6+s2/4nB+ij5o0m+YnxnG1bfkpDS
         bvOycRTJ81Y0gpByTHj+BGeBivjqXAFWny+1dQP+nnrSvFKNANoLHFoWlMduEAsCiXwt
         OKQ4Pl2IRaJYoo6sTV92paV8ljoSBA+K/yCZcM+r+Qm7l7ClVThbwqYEJ/jQEHQ5Oq2s
         OA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707445143; x=1708049943;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YRe6fwQoziV3zDsr1DVI/okGNuaRvDvH8YZwQd/sb4=;
        b=PLudEUfYHaGVPVS3tro+5ppRf0Z1fj+fRGw4GTBUaHl20LTkFUqp/N8VcA6kB1m/hV
         rKx8s1zPhPMLlnPyZXtK3UzVE9PdkHGIy9djkSZ2HBr2+ahG8xujYMV7/C4IDFx8RmVk
         EGM0WnAYftnMsDc/B85KCg15kcFeH0OximZXzmlnyqW0tyQMA0/nv2DA3Ss6F/CarcUh
         GRYhKE6HDiyIj/t9FL0/AnAE/KR6hN+pQAlSn0y77hfnJapi9zAoNs7dgjxrkethSsnU
         a9gndymH4XS2treFsQXG9Ja1qsNjjk033zkamFNGe7za6rsOkGjeytb7vaV7pUVBP8El
         /rag==
X-Gm-Message-State: AOJu0Yw22uSTzdLZC7fAsriJWKHto6UMK3ogRxF5Xi6QtnWLfq4wyK2N
	U3uPJAgLyj8tyltxdUi5uvk0HxmM13H5muoiof+YGR8XiD7v4Bc=
X-Google-Smtp-Source: AGHT+IE5wIgUKdf0QBznHKG6nJEPG1pSplGU759y1rGePWZCv/bEz0MVS2rGjqZtvDi398OYUUn+wA==
X-Received: by 2002:a05:6a20:d493:b0:19e:9a65:75eb with SMTP id im19-20020a056a20d49300b0019e9a6575ebmr509178pzb.40.1707445143493;
        Thu, 08 Feb 2024 18:19:03 -0800 (PST)
Received: from [127.0.0.1] ([52.238.28.183])
        by smtp.gmail.com with ESMTPSA id ka28-20020a056a00939c00b006e0651ec052sm477044pfb.32.2024.02.08.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:19:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
References:
 <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
Subject: Re: selftests: mptcp: simult flows: re-adapt BW: Tests Results
Message-ID: <c070bcd6-527b-84b5-7876-2dabf3d21d87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 02:19:02 +0000
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
com/task/4644410579746816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4644410579746816/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5058570014687232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5058570014687232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cf099624ce51


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
