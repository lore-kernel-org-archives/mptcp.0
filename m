Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA11EEF8
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762463; cv=none; b=fjlqvD24L6QJBhMNhRUSF5UTdJLKqThZsjZAs7N2qFmtIGX9prpJSnOhKzqSu/x4YdZKmj49hiwp99XkSKz31dAqls0F+7YK4CwB23WXMrEzUgqRpvWni4hmWbJq8RlGXeHFSmwDBAv2WsK7pudL4rmoAElXCVDAnvdXII1xUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762463; c=relaxed/simple;
	bh=AmpuTQQqmZEx04lT8E4XS+cK7Jkaa9PFUYbJw06ib0A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AfDXbbM3Cx0pNcaDLWmy8985XOY+Jmz11WOVSjRzH3H2STuxYpyd5AVRn+fSd/MzdfNOFEsHtpMtlNmB3Jqfs3ftPOPjwg4KAUfxj0OyjYs9FPCSLXNRRlLYxJNcT90dVONdN8Fh63DkjyON3F6qSc9HKQgBMZczRwLDo0H6SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cixWT03o; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cixWT03o"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso2535716d6.1
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 20:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706762461; x=1707367261; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmTkRcKj/JlOBDwvEil+U022tmHScngMCnHLUn4Ylq0=;
        b=cixWT03oD6M8rOhVy0OvEI9V6PKLgPzaGRELv3ONCeivFv2vD1fqf6J6PVKFsKSxX/
         2auwYubz0fUCItAFdfRbu5drY0oQBNI3O1Vk73V4144viW0vRvvXqmc4q6EDl9fn8wM8
         luBfhTuf4v3nYdQjFt7TsYI2NYd6V43Os2Kx8n/2Pbl5qi5m/GPkxI2k0CMTyMWOSNO7
         CgbGvyZTkl8h+DLVTs2ZS8s5hn5RGMuf6orinVjnQTemiPc8tfJXEU42shPuCJsRYCIs
         2A2riUHIpntFm3Iw5df3js8Lt/rRLQdQ9z5nXE8J2+QumFab8pu1sG55m9y+obtfvOi/
         rVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762461; x=1707367261;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmTkRcKj/JlOBDwvEil+U022tmHScngMCnHLUn4Ylq0=;
        b=EY+RpDiS+a6sNFomnywfAg1MwIRpX+QKNinlkDZxQh2kBg6uU6FvdaGScg16UMYU2y
         J6aF1AVdBuH3lSPzDNLpqm5pZhYXCq5cczvte70sCiw6oCMAmRyjGYCb4m5Vn8oV7xyi
         AW3RYe88EKa0UAxnEcQ8SR2OSmodWpzt8yz5NfYUl9ulHZBMgzxVxWbitjwjgR9VuBav
         +ILp7ZqnjIL+UvJOiATmpjIuTtVVgvJvrC/trdncJNy/sKU8SVyO+CRVLz9lvKiFOYDW
         nfUGPEYveWMrdCr/EZsEPiu1BFb0Q5N7ORR9OQhG15PBIJsRyxru/6z+JE3+3Zm/+eCJ
         aVHw==
X-Gm-Message-State: AOJu0YwvKK78jLNf/jT4dz5Jnr0Jes+ThoHkG60ETC0mfA0iH2ySM1hP
	hBbT1YHWy8rBZyOxa7mBZef8l7llZOAXQx4aGqdXMj4qpD3JAEqu+2xYODo=
X-Google-Smtp-Source: AGHT+IEfIUMV/ZMNSZK6BFH10oZ60Hxzr0B2uD0JU1ZP3deSW6r52L/N13+OV5sV7e8t8wo0xsf0eQ==
X-Received: by 2002:ad4:5f8e:0:b0:686:ad00:3fae with SMTP id jp14-20020ad45f8e000000b00686ad003faemr3652690qvb.5.1706762461045;
        Wed, 31 Jan 2024 20:41:01 -0800 (PST)
Received: from [127.0.0.1] ([172.183.112.119])
        by smtp.gmail.com with ESMTPSA id me15-20020a0562145d0f00b0068c4aefa96bsm1506077qvb.69.2024.01.31.20.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:41:00 -0800 (PST)
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
Message-ID: <bae95b11-e78e-5543-5fbe-0c21f42b7ae3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 04:40:59 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7736093723

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4625d77bcf04


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
