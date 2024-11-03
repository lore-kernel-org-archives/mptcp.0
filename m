Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E0C2FB
	for <mptcp@lists.linux.dev>; Sun,  3 Nov 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673668; cv=none; b=i8cNbi6kl6pPvi9NWjF58nqH8k3mBGu93RQurw+QaZ5ZJ4J4FOdmsGMGLfEFaakXeAG1dVYFJq3Yf2m04EkUtdBZkHKvtTflSKrx4DC3WRn+K2f1RzPxZomXaetdDMNFH0Jy8JKmobXT29xUWlkjPyxiNM6OQ2EncSmFs6CmZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673668; c=relaxed/simple;
	bh=sqUTAxDQl145aY3E5H5QmyNWQCPEsZS7+9/xTuZR/T0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=t50JefkhsS4w7hX/5qwt7CTN8DTT99WcOjwK/Yx97nkenmUZQI/pRUATRSXR0Yqm0hKXYNXdV53r56FrWJ7IKLDVlRiH/LcFk8pmfhsqvLB6IGuz5D8MeI9aGmifMGxMQmYusCO7YfTqfPcTU0lSmJJgzsshipbrO6VKyHKAwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3fQmGab; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3fQmGab"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e98bfea0ceso1765894eaf.0
        for <mptcp@lists.linux.dev>; Sun, 03 Nov 2024 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730673665; x=1731278465; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=14FhnDKDG2QdHon/e00ECk0nrhp5Pj76YVWV+NS4I5k=;
        b=k3fQmGabs0ruVkhv9pP8iTXvSvh+fzz+ptiesjWWyrtORUsyj7EhkRgFCGW6Dm4wDw
         5gjN0wCWwQVTUTkoFB27Cj3KJcAp+T3gX9Q8vbcZk5I1xtLnAfzCRddop36j4t3tQliG
         9NPVoyDDTV+WSRNBzqgDw/PjgXd7G6SzMPNh/srbFMNIHpyRENJ5xwfTSS/e8scFbDAH
         kjOEm7AT3I0jnF4o3WSZiEqn1sERMtZnF4gb4tBi0jC/gcCEFDyOdLN43P64vhKEIDU2
         cnlcgm4RqGqYA5Fg5HO/26kFJQ9lRtw9B7waAYS04uHbwNZikWyyfa+4KxuIi8alhiPm
         5IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730673665; x=1731278465;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14FhnDKDG2QdHon/e00ECk0nrhp5Pj76YVWV+NS4I5k=;
        b=Wsy2tmTGdlVSDTTznMbS+InJXR66ax1Bf2uRl5xksXoaeABiSl0qta7M6d/R4rNcmL
         S+0Mt/yQ5zSZCajpSNu/xWwycBqcpl7NGlKyraSXrbQh4kA360fP8zAqOC5venw1/va2
         h/Puf1sZmA7lt9lkVOoT6pENAk6tSfMI3XmD/GJj147hdGLfx9HkThzYmSqDZb8ITWG2
         6eJFL4XyRDILDLLM/ferljjmqBRHS2u1GuyfaVpTtvCzP9FGITgqTt/12Qr9EWZhLyIt
         utZ0wnDP65IJAfGFleBw+S+vvOh6n6SuQdIaWrMAPupCcD3WnKZCkWtTmRq6kRJlSMGD
         4jPg==
X-Gm-Message-State: AOJu0YwAfbMPMb6fzwXs7JVFKfDz81NZ+wgiUf7MspB15DOB/HJrNNfm
	zQp5AS17XPNbghcezjKmimbf2Ohp2PI4mqYGjN0gXfKJR0aq81kXxqKbV7Fli1zGvJKeuWOMAcx
	7kkFZLFhEmdbY9JVuGM5A6ThnJlfIWuKA2FA=
X-Google-Smtp-Source: AGHT+IGIQom8BbhCgGJEIHT/4FX7auRx9wcdnzNv/n1sq7Gjs1X6TtY/Jo9cw2Bt8I/L/pO1oZ3gYC1zpmmAXrcljiQ=
X-Received: by 2002:a05:6820:221c:b0:5e5:7086:ebe8 with SMTP id
 006d021491bc7-5ec6d82970cmr8551510eaf.0.1730673665399; Sun, 03 Nov 2024
 14:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ossama Othman <ossama.othman@gmail.com>
Date: Mon, 4 Nov 2024 07:40:53 +0900
Message-ID: <CAE+88WOyHcXdia6o9piK-TL75zv3KVXVM3pHm0ruvRasUkJWFQ@mail.gmail.com>
Subject: mptcpd 0.13 released
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Mptcpd 0.13 is now available at:

    https://github.com/intel/mptcpd/releases/tag/v0.13

Notable changes include the following:

- mptcpd now supports ELL 0.68.

- Documentation was improved for the "check_route" address
  notification flag.

- Listening socket creation is now optional for user space path
  manager plugins.  Plugins may now call
  mptcpd_pm_add_addr_no_listener() instead of mptcpd_pm_add_addr() to
  announce a new address without creating a new listener socket.

- The script `mptcp-get-debug' was added to help simplify information
  collection for MPTCP related bug reports in general, not just for
  mptcpd alone.  It is installed in the `libexec' directory for a
  given Linux distribution, such as `/usr/local/libexec'.  Run it with
  the '--help' command line argument to list available options.

- A crash (seg fault) that occured if the `/etc/protocols' file does
  not exist was fixed.
