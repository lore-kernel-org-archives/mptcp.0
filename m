Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00E19E82C
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545686; cv=none; b=QxTJ9EW838mlKagAAKQs8fXZCMkuw0KM0OAkAQcT1GRzknHUyGp6+d8V/ygN4VBZHIukdWgcQKvOx6xwR2I7VfkW7WsqCs38FdZnrXtJisNJbKQctH5n0eeMchMNlXjx7HFWoId6P8IwQqZs9RtbrfVVILXiFDwayoBJ6WWsvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545686; c=relaxed/simple;
	bh=OukKRCKaQx/ZuPmiOSZK/bNwypeSKFq6bUbKGQKMMYg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dZ/24WijmuaBWCqAJK1qFrqtw4mr+DxK1E/bJHNG+IfOORo1ZXFe0udEUv14L3D58XC4Zumo3+mg4eqhtH0FoC5ebMcmXDfySebByRnAMyTd6oC2wJu5wJN3O7kUwQb2rWfHQRp7dPUuX2oJzDXfszBJZnbumWRTw0Rt4e4z4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byxIOTE7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byxIOTE7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717911ef035so467564b3a.3
        for <mptcp@lists.linux.dev>; Thu, 05 Sep 2024 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725545684; x=1726150484; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yDPkVTSomwzBjXIWX5zAuduCvEJUoJ/ucxfNbWkzIc=;
        b=byxIOTE7eu8Yu1QNoTr86HrTEbDYPakOZPd8k/R5I4vzkNMzcQ/oyulL7H1//ENjmE
         NIrRayNTOxqTlSriqFwCGLMGe0h7grAcXODcApeVaMhb1cDgAacAPXMy9o9fVOdILZIP
         DQqPHgLhP2oG1yjwvVeR1OGhbl1q3HGQrU7zTsMjCSO5OWcYGNegOEv+3d7oqQQBRv5f
         cx/L7uWCNO6XU8hQF0U4UVBiyXN0LD4CqCNfrFvfTRdO027QQ9Q3O6+Vtdc8XZ6fKK2u
         ZJuujIRBiyneo5vaYEVvpeCDoDJXw7fot9M84Y3MakjEdk80YQNT1FUgepUICD7Mk9ok
         d58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545684; x=1726150484;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0yDPkVTSomwzBjXIWX5zAuduCvEJUoJ/ucxfNbWkzIc=;
        b=r/kZLVM+I/CunJ1hq9jFIOaovlw/FNlu34b0+TBevcgR3fQET0vC7VuiFQPeoP4B9q
         PBaz4boDTCIwFnCWEwVcAqpHm+oQRn007yGdERAbH14Vyhs5N1r0EAqbAKnKbVlJlxgr
         c3Rs3h17i/QYA5SbM8hcf+GlLsaQznOIbXvgexEKItRSULlvtACB83qIup0C7ixwK+17
         6yGMnXE+1RBjUpvptp8T4Gr/7xkubJKQPgETSLMEFoTYwsWeSb/Gga7dwIczRpNDvhYu
         Il3OFAMAPUT8jg/I8xrX+lojByA8GYEIjEwnHVfe5E8IJvLS5PFdzNEJt33pKbLhDwDq
         wF0A==
X-Gm-Message-State: AOJu0Yyfs8Vl4CW0MDaG3swN/7iCyrHRXeKpTKTApLScvnUwpmZD6Ktc
	oVbwc/JIqo+k6zQ1eNNYrrsv8t0GqolKBCvoHfWo/aIsIm7rGA3Zbxs4
X-Google-Smtp-Source: AGHT+IHI7Vn1Rz0RkL+Yw0Ct5S5ZaXaeQOaxVRF5rzA6QeWvDahYuxxrkhgqEUbSP4LPkUp9d0ZvYQ==
X-Received: by 2002:a05:6a00:b4a:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-7173c3090b8mr18433380b3a.13.1725545684194;
        Thu, 05 Sep 2024 07:14:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.78.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd852b6sm3375425a12.18.2024.09.05.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:14:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725544210.git.tanggeliang@kylinos.cn>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] add mptcp_subflow bpf_iter
Message-ID: <cbf58752-cdb9-4c42-5eb6-39ddc15e96ca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2024 14:14:42 +0000
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
net-next/actions/runs/10721986850

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/88=
ad9420470b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D887267

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
