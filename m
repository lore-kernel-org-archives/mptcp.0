Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BD21B426
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047921; cv=none; b=QWoAha31YJ5taMHcZYPXwGW5iObwpTes1OlK9hzuYOoLUovhX4RXx68bw2lrmFrF1/cIcytqCn71YbIiGbX8kW3qHkc6bmw/3NNzxZDmB9VO2hdCGWPPf1ZRTRGWmO7ETc5iNLPuTTR7wZXFVR+VLRR2vTAzrVgH3sdukwvZBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047921; c=relaxed/simple;
	bh=M+V9zECiWXNlBpaW7ErDRz240agPZXeHrs/y2b/bY18=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=vGYvr6/Qy15JPuobZK2qk14+mlDVbLH/tHk77W4hFd4rnWu5zH1tQkcrMHS6wzvmOYtgZUai577SxcQ8PSV5PzLILfbJ+oLjqR4ffA480hkzrw18s6o3xZ2oTnzvdcHlklTOSUttPSqQpcswe/kCommmXgusmAHudX+AV2WJHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7xLYV3s; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7xLYV3s"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9a30a045cso175117385a.2
        for <mptcp@lists.linux.dev>; Fri, 04 Oct 2024 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728047919; x=1728652719; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/K+Ds+rYwRNWNDT25n5ubaBLey2hW4z0oJlot25aFg=;
        b=J7xLYV3siZOjRitrSPqnW7d3QTKsDCDHCWaq+agzl9OEVUj4dndxUMEhXKxfYZpll9
         fc16MZPcamhWMnApJAQAO9IofI7yVd7SswNECdSZoqs9JplLDJKTtiXWmiymoge7qcpy
         jB2wyux83gPmg/HbqfH7ZIaEeVfi1Gt0FKgGDYKep3onO4d49yDKudH/bblsgCTCzREe
         uWsd8iJK64M17fp2z0TPEfVf0my3abPF2quU9MWZuk7YoEIegiSyR5KKnjh1L3DSyySx
         fZDq5vE/hKShSBKiyfFxAe2tmgoyr4yCifgKzgGYibKkFG+rEMS2TYIMdObXBCEqXIWC
         rtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047919; x=1728652719;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z/K+Ds+rYwRNWNDT25n5ubaBLey2hW4z0oJlot25aFg=;
        b=V1qhS9YWbqwUM5Lc0hd/8Z8+WF+9xgp9GKrthnhqFJNy7XRGgCagk3akVNl5stjgxQ
         ZZvJi2DGp/OVp0Fm4iUBluNHQ1pq+UkvymDv90L25bjnO4yTltCQxREQjuZJ8cXTQGTe
         S6MosghHif2jGZCKKYZRcmHooLvYHG9ea02N42x6AuXRC4wUVnY3XpMyI6eyc2NRR3Y9
         CNWAtEqJNzY6nUKdSvEfGk323gu8jom+oQsB0IITGm0/PRwOuRltoOt7bg+knp0JdpeQ
         0T5PZT8h0JHzndK16tYi72BFNkj1V7fYg+BOHtboYp/hPQ1EyiDB+5WClwrcOsBZYByh
         gZIw==
X-Gm-Message-State: AOJu0Yweu5iyUkefyUrKkN+/Oe7kK/ZvqRO6eAgNlYyosQQQle+Tvmzr
	PcrtSwbRImBFNNdyksGCjo6TgfUEmfxoJKToxdZOrIQPDLkdTqxhZm7X
X-Google-Smtp-Source: AGHT+IEZQcxh7eNcOmJjLslMZ3ZHyYpHJR0dFrT4XYVGTAYvRL2ixq2doAGKNIblnLwpKPgqYBs4RA==
X-Received: by 2002:a05:620a:4410:b0:7a9:9ebb:9da0 with SMTP id af79cd13be357-7ae6f4463edmr347849985a.22.1728047918905;
        Fri, 04 Oct 2024 06:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3d3dadsm137176885a.82.2024.10.04.06.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:18:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728046021.git.tanggeliang@kylinos.cn>
References: <cover.1728046021.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/7] add mptcp_subflow bpf_iter
Message-ID: <31047d32-cd7d-726c-7691-a5a1572deef4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Oct 2024 13:18:37 +0000
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
net-next/actions/runs/11180592718

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b8=
cf8908f57e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D895563

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
