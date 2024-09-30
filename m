Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2211CA9
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664075; cv=none; b=UVyXTGW5ZiMH5n3utgE/IUD3R7b/o/V6Z4+FpeSEHBoigxbCA5VmNPL+GbLrMDw1gi0PAL97DocBikIY/3csLAr+QfphUfI+dQVlMyzRp0HKA7NiwhfLoaNn3aNqjRtrPbq/SXQ6GEae+f9H6M5qbsyApFC/XVz9RQ3ERQ4Ls/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664075; c=relaxed/simple;
	bh=8W42IQKAWbXHtsIuLOBINdFtbEmUCsqYSoiCxdbDfLI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T0vEQU6SbYmCJvxC9c9Fgnfl0DJk2aQZpXvKyD/Txj+lIyjYpZ9zQAzNRqCuPy1SpqqsMYbNdcLpEuMWGjpqYfUQFGU+xdakUc+NqUkZ8EZ4ZmfLh1qkb9pbqCLdhkudJDK9ZBcP+C3zj3BwjQP4UsD6/GTqeTK+YIBmpx3SJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIfAxwq7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIfAxwq7"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4585e25f42bso42017241cf.2
        for <mptcp@lists.linux.dev>; Sun, 29 Sep 2024 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727664072; x=1728268872; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/SfJzoKfypMXjcHGeXshcz3IT/sKIeOsX1FTiWfy2A=;
        b=ZIfAxwq7dMR2N9QjIcYucJ7Uu5wWc9574aeUeuW7lnu9jMnVbM3yD22dI6jXhOO2pJ
         8Y8T5ve4QBf8Dd16zbl+eAVShUorNMeXQdgn+/p30l/qXFnl1JFd/pQ27ekHoDswK088
         nmH4JRN0XLABjc2LVl1UKew/vDi4eiVmiWEG/vEILjLp9tvSZW0d8sqM5wLqjOEkOdqf
         erCQzu72An95mUKnKFyixdlv7sEXhjflV7F9bAOn0v7e8FY3u8bmJ8c4GKO0lfUWhQxO
         hHDfNSnNsMq+gN/rtph8B9wxImEsBzH/5FpcGDvHgfQLY3yHo2pB+hYwGd7eRgJHy4vW
         y0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727664072; x=1728268872;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/SfJzoKfypMXjcHGeXshcz3IT/sKIeOsX1FTiWfy2A=;
        b=S/jJ8y55c6rL10GP9UsrVM0swS7pZt9yv1r863O3+qHfv3M1sYITXix08aXWg4sv9Q
         16jB+zdk3kFr5giUt7xHX76T1+CaEVV3YwIQHnYZdQgn80Y4S34dEOw3A6dWSt2M4lUj
         1XyHQj1SqbtqBt5gGB6XSEvbTMcU6ALa5MrIoBftMY1gOrS91njLxMVRhZeaWk0AMai6
         ycqgRtnjrvvYiUbtuzvmRfbkN0BfYjVjo1qWiETN83N3akbQWJ1rqeR5lpFwJ5F9xRkr
         9VBg+XSTGyLey+CiTengjZSD2doylauuw6AsMTQQkxbC/PrxNRFZyl44fXiUCbuvq16V
         HwEw==
X-Gm-Message-State: AOJu0Yy63uCyoEwPMpf1S92cM8YBiPYscDqA914HdJFIxWcmggk5WVD6
	hLK0rvefOaYmNXXcdIsswUZO8AIGVpE24BXhGh5kSpBmdr93H8tIWo4x
X-Google-Smtp-Source: AGHT+IE2q1L/Dn4swqJ50NX6LSM4p/E2S9GpsZWLRyq4S1RcqUqmlvA8SaYpfNq76nn99dIi4ozCDA==
X-Received: by 2002:a05:6214:310f:b0:6c7:c668:17fd with SMTP id 6a1803df08f44-6cb3b5e4e53mr191807766d6.1.1727664072436;
        Sun, 29 Sep 2024 19:41:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.13.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5fff6bsm36338796d6.2.2024.09.29.19.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 19:41:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/8] cleanups for PM interfaces
Message-ID: <32ffef7e-6051-5317-0f76-eb78c6d0c91b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 02:41:10 +0000
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
net-next/actions/runs/11098291328

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2d=
8847051143
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D893831

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
