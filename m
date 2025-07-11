Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CA1E5B73
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218781; cv=none; b=W1N4tBUXKZs/xJU9RO7t7qNbXEcWcMw5S3+kvkQtXiqIKTkmt2xL2BzaJxrNV2h0tZeHSjli0adbyGHAKCoRVY5Je6e42hER8L0CPJXUTNttZd9V31MJu1EwejHrfqiCR2yvd/kgTq0Hly4zDEEaAETFONRFPMzUoW5mqMMrl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218781; c=relaxed/simple;
	bh=Gdr4UG6vq0gjHJmrlMf5E6UQQLLLXH/6EgzjJWfJh6Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iLrH5eSrrMaghb6oBk/i4zlSMuAUkzAc3/ZYtlWDDoTfUgGgve/9lxaqSDpLujE8Kk9KDgjFtzZYHPCWKaL+rdvaK1NMB7dNpha42oWQsOyctBnoi0zho2uPLBjcLUUvGtkdAKTb3lQ5NQiuoIrm5ij3ZLfITMSOVhnH3eLS6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9CLXxJn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9CLXxJn"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso21737276d6.1
        for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752218778; x=1752823578; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFnzHTCJdcZ49sWHkba3GB0QReDDjHikplTJ6hMnyrg=;
        b=V9CLXxJnsJ1XpBmYKM8baLsO9oQz9PnBJ7+gdQU9MSUcYxcYTaARmeSeksNojdiJhL
         5txJtbeT2+i+gXMLli2/TOykMK9YiaBzzm5K6qbI9cTRiNKuMtlRdj4eCA+9183Y/YBF
         sHrPfx76u0SrgnLX3VsWZlsBgTcxdbvwA7OzuqqRu7/opSW7ZnXk/M0tmz/TMRLm2BTf
         i6qxJQ71bLVBVOcxFzyn54Ztw8Tc+woaGU+QSxLnZDOBVRDJkvbPaLccmc50LP5w/nKL
         yXGQZIk+vN2KFlThBkwska9/IjcVb0/NHIrlkBrnysIeaSsVkVGCU+XhfCWPvA7cmnng
         BVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218778; x=1752823578;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFnzHTCJdcZ49sWHkba3GB0QReDDjHikplTJ6hMnyrg=;
        b=YS2sHZWX3ycwT1NjXnBYx8jyuJUqUkx6mGNgSktDId4oebUkxJYo18bvHtuzYwJkAm
         muyhWUt7oyfgSVtKB2d/iHl+jAH/xQEU0EIaPItXzjE53p+zKEyHFCGscFTcgKPrh1Si
         MCUKhOyeHk4i43RZx8rCr/8GfC59IGe7+CNVINckezV84/RWLN4Gvhpdca9rTljSb9PS
         yatyeZyXrhLRjv0aviLW5RCrclet803crRuuQ1YuKad1rTjZ+INwFUH5a5I76IIZRfQB
         eyZ1eZmFSufSct5tsDbcOCQAQdMCzeHJVgEqiE6cD2YVy9fCmzJg3c36KHvDyH8wFyo2
         wbgQ==
X-Gm-Message-State: AOJu0YyFN9PE3fRkugiRN70v0XN7g+xYLVS/CPc2WPi27uFP9K6R6r9R
	mtuWiCyJNeg/I2kgPWR6NtNJ3OgVokpyV1JAmvp6RWEtvfyHAQyiXUh8T8nf
X-Gm-Gg: ASbGncurdnk/OR8F00KZorjMWVZI1vVgKfaofPLmXhxa5cBizty9RCmqhzT60feZGTq
	21OYg8KtnT1rrwX2dcN8W2w2/I0mfJZc2MDdUkQLJttGj6Yiqb0Ec/4XEgJ8ICVS+nj1xEVVB0v
	McyeflaVTirYt2joZsfhnRFv5Jn/kd7/MezDw8gk4vO37q3uBpB4IUhSQ+qmlf9L8r5QY6TgNvb
	rBGo3FnN2/4vekIxEw27UmWBcnhkfXkkMGG7zoEc4gNsjRmbBJFYYcDEmFFRDfVQI+TbYl9zAB9
	Zcss4ebi4zwO3m3ORuGp0Lpqwry0LyEscrQB1FvHuBXekX8MVJmdmDHIR7W6Nc/akPi/gdxujZD
	HhnbYVGNKwVdwVjKsBoOV6V/awUA2Jp8SykCwmw==
X-Google-Smtp-Source: AGHT+IH/e0WpI80AiFWzPUVis8chlbX4DfLfLU3WRFW1iiBVX99UiS9CIaxT3Y20QGOnrLMMHrXUUw==
X-Received: by 2002:a05:6214:caf:b0:702:c11c:2563 with SMTP id 6a1803df08f44-704a3fad887mr37065756d6.15.1752218777748;
        Fri, 11 Jul 2025 00:26:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.210.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e45c5sm17688966d6.51.2025.07.11.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:26:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752197546.git.tanggeliang@kylinos.cn>
References: <cover.1752197546.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v4_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <0a896012-fe32-1aba-baf3-d7595ed468c5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jul 2025 07:26:16 +0000
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

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/16214201126

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/377a22ce925b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D981305

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
