Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE83A48F1
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120815; cv=none; b=rCaRjvlmFPsudZBWt6avOBotpRfCwLLTI+OB2FPWVOhuvg8E6oS2bqhC7I0+F1KjKTBlXKxhZ2ZJta4kfAks00MELL6AYtiHY+TpFyXG+kb0Ks3iLNI8wz80AR9e0eud8K/M1J3CBlgKcJRxSU/sClDoj02On2T1ziAo5aQMB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120815; c=relaxed/simple;
	bh=+xrW2CbH+SSijg81eHGu97x2F0Yff6+98XVB9pQH8mQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qw/v74FclVb4hqiyKiHHZAx/qeGnhF5Mmv4bQkepA8C35xQbEleVLMEWEfb8uygBBxHF4a1gUYq73RzOZpE7dYWeS2WRLllVOYXkYVdPZ1yVsqOH/jIkgCZMeNW5VcFQGg7US4akyNkVCeWZeNFf3zKh0etHVgBEYmYWj/rwKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLd3m5gt; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLd3m5gt"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0e5e36912so17225676d6.2
        for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785120810; x=1785725610; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WGa37S0K2zgHlhREI6He2FAFrV5NjzatLpqKIpcHD6A=;
        b=ZLd3m5gt7JJJZe51QpptUDmNOX9+C06z9i9udACMPlDL+nCyJQp3eaKkF1vDdJQzgV
         TsQXDZmRR7hL/qZFdw4yKkjUS1h9IvXj+ekQGb+Hqs5Q+gSyzz4TMjsxQbucBMwNTW+o
         f+uSDRhHJWy1gdbzLZF5PcEK6TxAIGBJRgftXB+zWC2sayy4LOYJRWGj2r+G0WPyQtj4
         7IXkUSFxnLHimbeqr0Or68GEs19ULa9lx4T9b0M/FbKjahtECsK9ubzfhFp8edjJlmJS
         q2cqbuFeKkDMKvM3UDffdemiDx7kXsDDvtdb1K+j9fWOmOzwtfmnpmlAxWHtwN7qY+OI
         kuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785120810; x=1785725610;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGa37S0K2zgHlhREI6He2FAFrV5NjzatLpqKIpcHD6A=;
        b=hBvhKQeNEvaYccByfIB5V36+E4LFEt7i6CXT6uTBikIxfTG0yxQTlxT1i1xdIVXhdf
         2PFSPlaRz5OnWQrQ9hlLfomiGnYsEV+UXQ6FEww8NFeRGK3oI9h70s2o2EvQ4J/KXDIX
         RDQSuH/TduerhozR/E31dlm/a59e0D5vh+CCQd8ShlSGEqdoIx1GWvE3LZzkyL7T1hFH
         BLcc8gQ/caI0LcMhvENkFbKF524Ras+UVmgu/EEShuwchJHSqI2t1YPOrXPvtKolFHP9
         v6IBisHA3FjLa7dyGwLjQ/kgmbvaD+EAg9THmt+6F0vdR/g0mBtvTH/7o2gEh6LyXpgj
         k4OA==
X-Gm-Message-State: AOJu0YzhWqXqLgVn8vA9cqNv95epsdwxL0tfLNLPfA/KkpCSm3eksUDr
	grv5h9Nlv8Qr9aSab5rHz2bBx5z1TQLV4fUJHKEM7XXiyByeflGmz8Nk7qii7oY=
X-Gm-Gg: AR+sD13f5ljoRtrjwZOeeMq10QkvMhiitJdlpEHsjvwofK/q/TbQnhdz8dJfsaXAw1t
	zNV8d5GU65DdVF2tvlkl9gb8SVFVptH08NElBBzYx7LFDy85dm+HJ8qnpE81IVaO0TNvVnksjkN
	cjo7FO3Sil4blJqncHWiDrszE2BTp6mmnbzgFkqYatv2gGg8Ym9GBbJB9J9vtp26CV4cYEmJVtM
	wbyIyg9phfXS6kJJwvgmkgdmvZFi8UjCBE3jtCnWPfcrGDpbNECSUPGvaeEGyMARdzVfe6E5VnQ
	Q36Iz98wInjB9eMNK3hlFU3CWIF34f5P4J4/CuS/adfT+lDSzm5KQHpUPJjFELItYG9nb4DARfm
	jE+RfGdH2OlMqu0E9N8PAbrDRUQ9qcRW6iTCbP1np+AztDEKbdQN7BDeOx0Hn8IBBQkB1McQhmf
	f71Yy2vdm5i1DhCg==
X-Received: by 2002:a05:6214:2487:b0:8de:9230:7c77 with SMTP id 6a1803df08f44-907ec76b14amr90410786d6.25.1785120810070;
        Sun, 26 Jul 2026 19:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.206.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d75afsm54327796d6.35.2026.07.26.19.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 19:53:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v3 0/7] mptcp: add bpf_setsockopt support
Message-ID: <f0cc738a-45d1-3243-5f21-f4cdaacc1398@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 02:53:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/30233020759

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ac=
b09ec8b8b1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134827

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
