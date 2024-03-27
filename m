Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAE1EB39
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557803; cv=none; b=AfSssUGHzI1FEr9Ivyc/6pHCJqP7SpKYVIqSpZfBXqp5qh+DbC1O6DxxhasHZ1pcXbRYAeyzqvFY9PktmklRPWe1kfKwG+Ov40sX0YQgbF90oOSpKSOeuaQzvjh2Ty41CIBXpzic7mhNSJ3X+ndaCArWaam7NtzPh3R1sXbKyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557803; c=relaxed/simple;
	bh=kkpBgw+PGeHvzK4ajtdUqeLrFRz34j8tMZSdLL0WpaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DATnccwBxEaBngEifJRUQ5vcbxWfW/p+l8tM6IsAYQUxFujMj4FQJC5aQTK4xw7jbrHLDuKqbsOZzVowcnXiBcuVDAbodbe5IuGl4mlrwzDy0sqG8emVLgESV/woYEGBbQfxW/ZmeXNS0wEqKBmGfqseBEpIfWlxZe3MuyZYAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKN4xkF6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKN4xkF6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-341d730bdfcso2137396f8f.1
        for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557800; x=1712162600; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5mirojkTcTgwKJGaOK9ct/ombmL5I/keJNO+8NwWkI=;
        b=bKN4xkF6hsv9QD2Jmk3Vm8bDtfhF/nKW8BWyOr9M4sRzL3DEGf1CHu40ofvr+tVB72
         5o47MdRLQ3+MAgqMfvYyBVAgZddkcwx9oFnusTxtnS5swKSVn6tTWXmjz9Iru/yaY9eE
         Bwza6xaoPSFQSv3WLGY139FXZKj/TX2RdWWYGCOzoZEaq3IGsNbsPFhAFfJ8WaXt9eOg
         YFaATNUzhWpSnbQU5WVvfCNTPqeqnbbnAh/5mRCDnC1F9NBYAD56cTkUKCFkeHmbKF6R
         /BmK+O1oif5XeGNMo+NX7pBSby9gHQ0kOr8rzClqQdTOeys/fsJ3zXqFA87GNncqmnOa
         iwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557800; x=1712162600;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5mirojkTcTgwKJGaOK9ct/ombmL5I/keJNO+8NwWkI=;
        b=AKxMDNqRch8imM1omo4lAkysnjaejs2qvUP+C8fToNfWL0VOrwf4WwZ9mFdzm3/zjg
         wB5T+hbkvDFT4ROFE2paH1UZWPMNMnYBxiSJECUydoPa34xr2KmgDHwU+B0mBaB5vzSL
         BSJ0eR26NPlHVHbGZdOuqb50SV/cNrdU9vrjMONIhCt85pLBbtNsOls+jXnqZM9MvFvj
         4Y4K/6PJ52v0D+LRSJZqV1v+mcC3eeXOL2dScAoZyaXdcV4SN8+uXxf2w6TLPSlnoqq+
         oL9B4H9OkZW8wk8ULcg3w9QttWKeCVRe6dXMy46QBwbnuRVHBvosMA0baW72/I3YlK1y
         e/HA==
X-Forwarded-Encrypted: i=1; AJvYcCVRrnyoL3YhuwsAo1PAfbezlVCddeaklDA0V2cEJBLBcikHwJ8jm7YybZ/IKMbqSo7Tdcg8uBgG52I7ii9DNBryp38u6bs=
X-Gm-Message-State: AOJu0Yw0LrDTUrByaf6FiTnULR9tf03J6zW/qZq4PO0ZvRXS9pJIzR+p
	w3Rc+9FNXNGViNxmIlk2WVjTfS74ftxXYfA/ClvYVhnQ8ccrabJ/MVTI1PGfFoh4ezuTiGYUGBm
	Drt4AOBoYYz/w+Z7Em71kIbVNQG9DiZGbe2I=
X-Google-Smtp-Source: AGHT+IHVecMMxxyWKllSyg1xDrzwb4l3tuFzZkiYkH4yDk9nzjGsfF6UoY2RMii5YdK8jHC6tH/MsLSHAWsjicQLHKQ=
X-Received: by 2002:a05:6000:361:b0:33e:7a71:1a34 with SMTP id
 f1-20020a056000036100b0033e7a711a34mr326173wrf.57.1711557800288; Wed, 27 Mar
 2024 09:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 09:43:09 -0700
Message-ID: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
Subject: mptcp splat
To: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I ffwded bpf tree with the recent net fixes and caught this:

[   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
subflow_data_ready+0x147/0x1c0
[   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
bpf_test_no_cfi(O)]
[   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
O       6.8.0-12873-g2c43c33bfd23 #1014
#[   48.467143] Call Trace:
[   48.469094]  <TASK>
[   48.472159]  ? __warn+0x80/0x180
[   48.475019]  ? subflow_data_ready+0x147/0x1c0
[   48.478068]  ? report_bug+0x189/0x1c0
[   48.480725]  ? handle_bug+0x36/0x70
[   48.483061]  ? exc_invalid_op+0x13/0x60
[   48.485809]  ? asm_exc_invalid_op+0x16/0x20
[   48.488754]  ? subflow_data_ready+0x147/0x1c0
[   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
[   48.495026]  sk_setsockopt+0x6c0/0x1540

It doesn't reproduce all the time though.
Some race?
Known issue?
