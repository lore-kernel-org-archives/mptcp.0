Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A5233735
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136787; cv=none; b=SiZnz+6tyiatT/iX4qi6dWnWiGngmFQNzJ1j9Ld13jVh08q180oddEk+nIk9omzvOyR/fRqT0856bpvE9/sFeJ6ERL5Kk03ODPUnlJk1rpghizFkn/m/vjP00ehOpzbapxN5aynlhd+2Zw4ACZysb9avS2Nyb0J5pgxrsdaYNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136787; c=relaxed/simple;
	bh=Y1bnBSXNsJ0CZID1Rk++wKOwtcCcXK/GvoIN+4MfXZQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=q84GuR9RDUvI3v5VTuiC7l0Fl/7X+RRPoSY5qvzj+qDqV0gqiiXPl+3fPuhntJXdY47irOCK6csG5eH5xpV00EMmuHKM1MNLWYJxJydtF9KPRLdMv3+kEXga5YiNSpCtG+4LLIBnAi6f1TZYds1O4P0ncXxDoZYw0TKObPZgCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsjoaLAI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsjoaLAI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3dd14a7edso115751285a.2
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752136785; x=1752741585; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COQ4ddfcPpXuf6AzgUxndYIuu4sjhdR15YQDe6U7D/A=;
        b=CsjoaLAIYkAcfnAnjYU8XA5qWjozz3Mh+D4ayJYfVVKspk2DS0ya6ZCJ0/wHBiHTE1
         0NdfOBmflLWqlsMGu24GaS11wn3sw7pKwtZqAI78vpyapZizeI4NJNPXVD4CMz9IQf6q
         XHqSRiRit7oAAjAAC88YfYIP4J3dBAobN7sz0XhmuL6VRknioLUqAmWEwOCIjg3tC5ps
         erOy2CXx8HA0lq/UYgX1mIFLpPcjwCcmSTu2Inw6PXb6z/vaDJCZyDB1erWeTtVdcm3n
         mDEBMv/lEZbYyUccTi2Yl6Ke68AIB6mEG32l2S8SDxCWDuqcW9SXgrUZGSZqdhuCcUd/
         2KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136785; x=1752741585;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COQ4ddfcPpXuf6AzgUxndYIuu4sjhdR15YQDe6U7D/A=;
        b=Rnp3CC8guC+g/ML11/yHk7Uu3Lqi7UNwCKO0d803TRI8ZLNAd1cgZrR4+Av3OKLflf
         w3imImE5oy5GMWthFW4Y83oD6eHi89LFEqgUjcYDfTxctLqwtYMyzbUD1DEogA+G9Ah5
         FdyeMGNixGaAbMMzfGeoXS1jQFBMggoekJV4TNP8Y2/lA4NvM5zTHcc0J9oa0MK6O+k8
         yiC9i38nx/ShtCbGrPepi4jNUxRZYHG7VzEZecJuoc3szkuG3WEgcCn5fR5e0M1zb407
         xKyi2JhdgjP7UU1bJ8ixmeFywWmHG/2InG/lYOgt3iK9a3SrYs/ruUoe4TAjDL3Hj8t2
         okpw==
X-Gm-Message-State: AOJu0YxcXu49nlB7W31cph4fHrcC02S9Zg012gJK0U6s2e3ZfN6iSx1+
	dW8T/vn8VJbfOmmGHITqIsuPTHZP4qnJc0icy741DDq8LghLsiV5uyuAanRb
X-Gm-Gg: ASbGncvIyGNwfy1HOn8dTDyy/QzbnHNYqn1TqLXLm/am0By/6IYnQGqv2m7MhD2NJp2
	RoFQEt9BSYDh5JejxXFB0Bb7+5nVd+WN7qJTv0bFgrMV9kBJIRZq0cXljeX3h7EHTaoXr0BvzRg
	ifN8K9QU5KZI0yuaQfSAhgKEbLTa13cEyrod+wpGQCUvpZNqZ9ydSnuIqpb1DpYFQlMxjaEZzDJ
	xuRw5anAu0wJahVZdLYwMxDEo6NJO1BnA1OkiumsSNANgbq4EjINNjMDKxIEr1F1wtNQK0Gkt4C
	/JmoThCbctbhAPVduKfmmPUOwtpSRQ+7ah5SxPVSxrZu3DHxDaXYeqahvMSBDT3TArDLezVAv58
	=
X-Google-Smtp-Source: AGHT+IHhdK/iBLxKzVmEVK3Vd5qLjfnGPgmqBZckA450t071sPaTfXa8HU9iJgXS7tM7dgUVSviS4Q==
X-Received: by 2002:a05:620a:4803:b0:7d4:114:f81d with SMTP id af79cd13be357-7dccabf2811mr197035585a.0.1752136785200;
        Thu, 10 Jul 2025 01:39:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.214.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f8689sm77136985a.43.2025.07.10.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:39:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752135065.git.tanggeliang@kylinos.cn>
References: <cover.1752135065.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22implement_mptcp_read=5Fsock=22_?= =?UTF-8?Q?v8?=
Message-ID: <09e61616-8782-8e9f-2797-a1278d95039f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 08:39:44 +0000
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
net-next/actions/runs/16190147090

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/b9f1f8861133
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D980902

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
