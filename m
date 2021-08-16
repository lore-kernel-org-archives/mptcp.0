Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62D2FB3
	for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 17:26:22 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id dj8so19723016edb.2
        for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEi62d2n8ea93OjvAzy5Lcrbr27BQ4EM9buUM7fFHjU=;
        b=Wzz0df10hZKarrz56Gc8HqubZTA0haY1PtZ2rwYwRHyrJLyvYBlbX3ae6TpClHkEWK
         2dcGMm74gHQPLTzmkQMyoVAhq03jEkFkM+luKOf9JsivxtZr9lRE7RZN0kxLLjN6gGI7
         OmPS5wNtKloZosBiZ/Dhi6rWIUmuEEYm2SBMuOg0i1bO44oAU+QO1CdZACfT7bha0Aer
         VkfahHC9VAYN1MJzAV4mS1dXYs2YQVnupxoHFNBfkm3MrV4wIlBfnQJhrL617q0oJbZH
         TpnH2pV8v7zbdBNL+1U6k38FjKbACjG3XV6Jsoqz3tgqh4H2tNvwX4RADIUn2iXrDreS
         TY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEi62d2n8ea93OjvAzy5Lcrbr27BQ4EM9buUM7fFHjU=;
        b=qtL2ikJ3aAQ1t3rhJZDeisVnHXw9A9/wqPutyJ3yMbISfzpWseBrQD2LkD7lxY1Hl5
         nGjc3QjwfAKml/vYC78Z8M+8XfGSdoBHilqfEWIg6xCVJ8Q1XRUvQO57s8KzVyoUL8nO
         h+Np1l0aQRw1yN8daehm649ZSHaPw42hGWP3qMRx15lgLqPHsgNg26TLcCkpkY7TiLbY
         ZPIBh2P5OTjitxqL7NpofHSMq+icjyiYNBx3z9YUHVIi6IRKEL+zzqm/hxARtVu79pgZ
         qj9KWksDQTOeBEO3goGlPGAagyibR0yVKaxwcsFDPfPj7Y6ydNnngS9ouL+jrEF+Sdy8
         ciqA==
X-Gm-Message-State: AOAM533AzG8OAYxzvIl6V2bQXo3sR3rbTgaeWs9roxpN80XTBSO2W9hm
	HiIY8+7HjxU6NuD9A2r8Q+IX8e6lyiMFx3yaXfs=
X-Google-Smtp-Source: ABdhPJyNIoXo1LJt7Et/y7TsBJmhAvdoC+75R50i3YNi5ynWMUwPNh1l0xdaZifDqcl983VDWBfJkA==
X-Received: by 2002:aa7:d815:: with SMTP id v21mr21441035edq.262.1629134780617;
        Mon, 16 Aug 2021 10:26:20 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y2sm3912981ejd.111.2021.08.16.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:26:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v2 0/2] mptcp: ADD_ADDR and fully_estab
Date: Mon, 16 Aug 2021 19:25:46 +0200
Message-Id: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v2 of "mptcp: full fully established support after ADD_ADDR"
but now we also make sure the HMAC bit is present (patch 1/2, as
suggested by Mat, thanks!).

Matthieu Baerts (2):
  mptcp: check for HMAC presence in ADD_ADDR
  mptcp: full fully established support after ADD_ADDR

 net/mptcp/options.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.32.0

