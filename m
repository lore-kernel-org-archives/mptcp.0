Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D941B9B33
	for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221027; cv=none; b=tp+/Ms+5U1Di6xjRWGv6olE924p4c7DwczvM721nz0PjkG6LgJccFSzURRUB/4YQ4qPoPzEyuyiHGoBmIFFvhVHNikersSQnSlBgLUbBe/vxVjUXKMAOZGqbEvK0W1h1ws3kkP0a0IQTGLNPBpenZ29BRjU6R6rpPd/nrbMHAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221027; c=relaxed/simple;
	bh=vVvbut8o6qpeo9ByzwplgREsc46c2i4WZfwRQnokwGc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hSY3i/9b8IhVHOPlwL9VOACV+wzM27pj6uerhiaKbDK5edQGSC2uSYFZ6VmACnPoJJDLy8k1guksrvLnHNWPkiEaDqCrn3PhumF5tf4gowE3qObcFS+G6suGcYm4Abxe+yH/E3HMFVFXZ6sVqTPCAqUtf974pr05epFtPjopwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL2yy7/W; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL2yy7/W"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581e0ed0f2so24376351cf.1
        for <mptcp@lists.linux.dev>; Fri, 13 Sep 2024 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726221025; x=1726825825; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj4/h4NmVkvh7/khKmYd1lWZ1WxbBa2woUN3Lnt1+ro=;
        b=JL2yy7/WFrbbWXSpiLVePaeqK1PxOGoAJ4zJ/WSFyskevmiJ4f2P1aZrzCZZeEeRN2
         fOTKYtolLOA41bAq5WRxburtyDycTWGK+8BBGO75g/mMOOfhhk412CuvBZSL2G99MAwe
         aBwLSXMnQ1kOjs3/eXd6ayZZmjRHh2vL/o6eA70PRa6dSb4v2Ri+0ZLW8Og+FW+VoOtM
         UqLQVWW24ujxa/odPt1DxzdvY0p9tPAf7fqiRjg56GFoxehoIZFUfTqdryUz9OKiwb+i
         +EzXm38MdsiCBvCUByTFOvgvdidkRa78GJTCfkHgIbPvocurQ6Bo0AejjGJea5+3WQt1
         iWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221025; x=1726825825;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vj4/h4NmVkvh7/khKmYd1lWZ1WxbBa2woUN3Lnt1+ro=;
        b=Ae/AZjTQEYndkVq0TohZbjN8PEgxAyZj4uInX7+tThkkAoUIS9xO6oPvo8f37H/5es
         yKzArTSIUiNrH7bkjCGzpoo+bFa5SvKi7OFr4frcyqAle4IC2wk4T2Uw531IDnw17YCD
         3YdeNZItuLPdscw9kH+F4P6PTjjC3yxH9YCQ/HDj35GqvJDGOrc9zfvwetuRItNPrbOh
         ZB2tAqyv7IRi8V9DXw5496gz/9hM/NhPsfn2F8yLU7KVmSrja0g/iX+Mae1EzUcb8vsw
         THikh+sqJDRhwBmQOZ6l2LKiBaDQegK4sqfiT0T7xYpfQPVJmp+X3phgIBtsqdS2aKrK
         yM0w==
X-Gm-Message-State: AOJu0YwRYGZBkDm+adj5NG20V/k7WyjykQDS3M2TDHsfYBSmkBIfiUZv
	IKUcOcQURjtYrQEYl21igp/L40PnrL80yP2fYq4uwNgDJsTPqi+S38+0
X-Google-Smtp-Source: AGHT+IFeBEbh0pGwYoBzd6mhTmtloIMUQGD4RtGcMHpcj6rDVErDZcDewHtjQouqlDyRunxB3tnPCA==
X-Received: by 2002:a05:622a:1ba1:b0:458:3b66:ace9 with SMTP id d75a77b69052e-4583c7c4259mr220419721cf.25.1726221024312;
        Fri, 13 Sep 2024 02:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e8ba52sm62952601cf.38.2024.09.13.02.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:50:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726217806.git.tanggeliang@kylinos.cn>
References: <cover.1726217806.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] cleanups for endpoint_init
Message-ID: <a8786d15-2bcc-ee2f-5771-9c1e2e9ba999@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2024 09:50:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10846366992

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cef5e8c262b8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D890053


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
