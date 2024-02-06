Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73056D1CA
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187108; cv=none; b=CYU4nV9wmjyxZOFNdL/PY4h7+A89bZNHbzmgftpmiiaQWOAVxNCKQTSQv4O2KwifZmA2Lx0CBP4oW79Lr1sVRfGOlRjYRd+o2zmBO8ImmyXLCn5Posx/ZvAzgPyTzcDyJIMB6FT6G1V92+/yp7DiB07d+Pj83Lqam4UFdzFokYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187108; c=relaxed/simple;
	bh=r/8fKQGqhOvIAyWObhx9Zk+exyl462iTjdYZ3vZ/iwg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PoRN6IEBK9h77nxt0+VQytC+v6jjd/Sk7Z32GJPQ2G6WsEI2Z0U46/Qj/eUDOjGMLgLnFRO6Wi1miHzjj1bsxrTV8jt3yCF2Jc6oZDSXMKDfk/WDQRNYyIJr/3kyAE+vfkNjvSxmNy7G4d+5s6Dkl/kKASbYIhfDfCKHcHP+54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7QQOe3l; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7QQOe3l"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso1079226d6.1
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 18:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187106; x=1707791906; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Fspxps+DQQNUAUtN0/NrGbK4iFIpHA0gJ8sVQLqNs8=;
        b=S7QQOe3llMfBLQHi7rbEB22Osyf3pUxJVy0LyLI4oh0M1pF2r6pvHLVG/aj4X++J7r
         4bU6LHyV874ApWVwtyyFlkEyViH1JNNSA9YW9B+48yQHgQl/XlfImkS5/rYRHSi8zzrF
         oEWbVsKvLqM+KeJQlhLxda7rBJJLK9MLtGjhNy5mu4+A1HpBnegbQZysR1J0nUENt9mQ
         DZDi3rv79jBlq/jyhkQkmaP9+ZQXP5C+6vYO9tmBaWB9CK7+sA7twSOf8JLGl69eq4H8
         biosVlR12hx98x0XHaAMb8+x1Th3j0o/lwB35c7zvDhow2ToeDZLD6wDuwcfvmdtR1Ww
         LePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187106; x=1707791906;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Fspxps+DQQNUAUtN0/NrGbK4iFIpHA0gJ8sVQLqNs8=;
        b=O9ZhlRlVeKYHbKiUyss0XrtH0fmdEwhTHK0H5JPl3i5zxgbIJfY46bm8KCM5UAMzBC
         ghrFWHglfhu5EUpawLwVBdfJQvL2mG8gfGNhS5OxLzLyDHC6GVSh2j9jW/lW094oaaVn
         9sl0sViklBLifDuKi9Gws/lMPoNe1c98ruKVL06f+FNad5CuqZjf4AAcj4Zit8Pp6I0+
         2Yj5XgTGGKyubQvjtiPk1eBUZ/XPOUQBOPrmArKzJWE4ojlW3T9QvM5FnQRvX5G7O3xl
         2oRuJPiC87Tbl5479OAUjPS+dG7GfT+XFh98DI19jMp4+zFqbq5hLfe73H5Br5VC4uRB
         77vg==
X-Gm-Message-State: AOJu0YzhH02fWdsA4GpbusDbI/WoEZ0s+StfNWMGBrb3ZF2x7eCnGWCV
	XNT6nwsBLHQaCWOSVcotpAaizZz//kKgUOoPqgqQYvbI5vq6/+S2gog9p6g=
X-Google-Smtp-Source: AGHT+IGstPSGB0r3TuDHNKzYqhG0SMAInx6TuAWcHRjs2rhVwY/9TcTku1BzVidN+8sovrU2HWdjaw==
X-Received: by 2002:a0c:ea50:0:b0:68c:8b88:ca07 with SMTP id u16-20020a0cea50000000b0068c8b88ca07mr11571841qvp.17.1707187105731;
        Mon, 05 Feb 2024 18:38:25 -0800 (PST)
Received: from [127.0.0.1] ([20.97.189.17])
        by smtp.gmail.com with ESMTPSA id pd4-20020a056214490400b0068cafcce5fdsm399541qvb.56.2024.02.05.18.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:38:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
References:
 <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <0d387f1b-33fa-0d10-7f3b-2c066de342ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2024 02:38:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5780927813517312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5780927813517312/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5217977860096000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5217977860096000/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/483bc6889d53


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
