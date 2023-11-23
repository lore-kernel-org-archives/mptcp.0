Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EED24A05
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz2utdna"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so524500fac.0
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 05:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700745498; x=1701350298; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQkxBP9pvcJtwwx8JYEjoo5d3XnlIQFI3v2Y10w+oIA=;
        b=Jz2utdnasA0ZyrCFA80eEgo1HOyShNCoDim4lOOjZupcjc14n5T26Y/yINgpqfltaE
         d5Qu4EXssWavXGvD1OUKo6+ebPLMYzgrGzczpfhqGfdmraBGnrW76DQ07bX6xwVVHsQt
         zLi2iXv6pYT7goXMCBqBgONGfONkEvDnxaHKBro60+gXZUPqE/UuKkaoPk6ZABFzAJoi
         ptp9xFnuHT9F5YqgaqbYxLf93Cgd4FttA98YgMKQwlEedBiU/+lRGfw86V2Ih2vwrb/t
         K6w7uWn/OihcnaDjhY/lgeXCn7lnfj83TjpG0A9u8HTOcfT8ttRMdiYGVKxIIf/flNDu
         8oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745498; x=1701350298;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQkxBP9pvcJtwwx8JYEjoo5d3XnlIQFI3v2Y10w+oIA=;
        b=iibUqctyBPlgbMWAA29Gn//PU40JELGfyNL22khoVKI2deTByRWoMjQe+GwaYsaarM
         HcO9X+wnFkrzriQMph4O5pl8WRJpUN2Ammvwp3YahN8wi2YwmQURz+yLhA3KhRc5r4ri
         1JMd4wGybIpCaRXx/70EFlMKG7kK0fsJoPZk3XpLRaNV5c76Ncd+sgFegtSfnGZpciim
         Kz7JoQ8XUJZERJp6wdyfpHqd+f+ZxWba/5P2BOLjO7NUnpL2OsfYTtlrSnHwi6g5qhGi
         mz/WRLZPwW8v3YszYq9nH0v8w4X3DvMfyBrxdB0toOd/npd11l6XCwEiF15b0tXZFshR
         0GiA==
X-Gm-Message-State: AOJu0YxWDDaZKp7GWyxrS2EeKjsy6kEiBunHP4k9mxBJWtJXnhZ2GRip
	aIrZNGD5yY5XU5bP719CT/187pzPbQ==
X-Google-Smtp-Source: AGHT+IESDYYw8oo26EyAs880lLXai8dcp6VLOb3dwstyngubm1AgzjL/Qj3NR9+JJ1fhIEvEavulxg==
X-Received: by 2002:a05:6870:7e0c:b0:1ea:cdcb:5a2b with SMTP id wx12-20020a0568707e0c00b001eacdcb5a2bmr7028606oab.54.1700745498583;
        Thu, 23 Nov 2023 05:18:18 -0800 (PST)
Received: from [127.0.0.1] ([40.67.133.159])
        by smtp.gmail.com with ESMTPSA id j12-20020ac8550c000000b0041cb787ff41sm465542qtq.67.2023.11.23.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:18:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422.git.geliang.tang@suse.com>
References:
 <bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: netlink: fix positions of newline: Build
 Failure
Message-ID: <2ac33b1d-27b3-9cdf-aa73-77eae8fb8c52@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2023 13:18:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/6970218965

Status: failure
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0cae163093=
e3

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
