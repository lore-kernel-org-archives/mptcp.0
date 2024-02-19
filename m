Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6245A2421E
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336045; cv=none; b=JLl4m9FF9k9ESModCkC2eWMwPnsEaah67yDkdthEoLmU1LiZkrZNs1fCZ3m3Uyru8LqBRYalMhC37Ll8pA4ue7D0OxBVyfkP8IoRlIApR0jqpz1gGeZiUdH98e+nfXUEQNWWW2GXnlNSfQ8MvMYomhgewhBoRvs6clo5GageJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336045; c=relaxed/simple;
	bh=855xTWkN5/glDNCRNk4SbxG3OIeZgyH0UpYSTym7EyI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XYw5SfyUVbw5MH7CNuIX6Z0FjiTpNu/WJDZoBiw1fShoBSusHOYbB2A1GjHTOZK/gvxKA1RE5naci2aaEpoyluBgNgDRg1XZu9Scqeyvp9yyAqXSPqpJMLDGmTMsOe0rocfQAhfymVpyaJabUxk0vZEFOwxW33o9rUVA59FoMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcCyicAm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcCyicAm"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4392786276.1
        for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 01:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708336043; x=1708940843; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juHgFl5es72OUnq2xISPmsCmvzNosugMyPze+nyt70U=;
        b=KcCyicAmLE8K+bAKB7Md5fvmglBywKOuu6YAx6Gc5o8Ug5W0a7JmPKBXxsCVZRUNM1
         mMr8m7MtVcqTjrzMfKgXYXZGGoqOrg8/p+og/aZ2/CLaYJoj6+usCFRuNIgGTtbSK0x4
         wUCjQ8WuNVssvPQLQeC+ECHqs9erNpvqRX5QZ+V76kX/pNeDBnk310AQmzyUQa2bASGV
         eXnb0gxIxcK5jHQ4q0gLeP0UbfJ6pgFO8Hb65tVymqD0JA0SHr0uWwncBb5L2T8nY2gh
         xLh5ykUv7GXLH2QiFa4DGyDugWIX68Ag0FsEBljh0vF3zKgt4s3L4SvMdfwj4+xmNnSP
         swWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708336043; x=1708940843;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=juHgFl5es72OUnq2xISPmsCmvzNosugMyPze+nyt70U=;
        b=xOZOxE4bNWM04aTjwK8V9+Vpm6cps5qK/X5NnwJUKvPxKkTqEYk43kuqziKdrrxvmB
         aX+a6xXEUB5ymFs4kOOc7NdgJ3V/JaK6ziVzJ7Rx9mIHwPSthA8AM8tlwl0t3t3/Qlwg
         /AkxWE1MIkNCIEFjXSzjfNUBkF/hAKICRE5Emeh6hLxxgd9lLW//PsurjWk8lTT+2leM
         W9AcmQS6l184v7c56WJcB4It4Y0bDynn86xImX4ufIiEtiAvtG3kTyatnKHH+qjDB24D
         KHuXxJwWdOaAxqvAn7ycbWbZ6Gy7QkRUin19IUa3SLmmcrb4CIDpTvmODr5SVTJa8MFQ
         AOuQ==
X-Gm-Message-State: AOJu0YzxCbmfZRDJBxGelDOIPglzkoMY3ENWhW6M08uJffYbfEmvcMxp
	9zI5jCjd8kCamrKAx4DCneIqK51mZ6GZ5QXKmNfXeeNNKgOxF9d9P6PKrUM=
X-Google-Smtp-Source: AGHT+IEyvnnFvsLLUrFoajucFRAdWDgU2gQt7czm0fPood7QIdtHm7kYvEev3A2DfN8YuWavur6t+A==
X-Received: by 2002:a25:abe9:0:b0:dcc:44d7:5c7f with SMTP id v96-20020a25abe9000000b00dcc44d75c7fmr9692665ybi.62.1708336042107;
        Mon, 19 Feb 2024 01:47:22 -0800 (PST)
Received: from [127.0.0.1] ([172.183.50.147])
        by smtp.gmail.com with ESMTPSA id i11-20020ac871cb000000b0042dfb466c85sm1773853qtp.64.2024.02.19.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:47:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
References:
 <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <7b11ab87-5238-ca4c-2042-2f4b68d11dc2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 09:47:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7957112646

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/12b9b3053efc


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
