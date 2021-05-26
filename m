Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196570
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:36 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id t15so2168046edr.11
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eMm0ezy8VT4lFNUlNPUxJVRZnEH3kBep31I7nhJwUA=;
        b=L/HUMandIzCsyGJKU6NCy5ulkvujTdO19AjvGGFzROCEodlINPnvXiZ5TYzCmnW7hB
         QeSyVqL9D5y377yu4czmaEmmjz8bY4uZYgJLb006yXKxi/bMbvGOVpZuh/XSIt7Z7Kmm
         OCAgKx8wmGJU229ICdBBhyDhV/zDztOVsCL0rzL2cu0fXCdSdSLPiSC0k8EtFimG7X6Z
         UcwDvgE8Gz8DUZAasQHHne86gQiD9CDhiOZ26d/n1QWbncuqTEfNP/WEAjFHlZC+MHVz
         vsaBp7ZfNKYIkjOqiT7D72qQ1x70rqY7B8dBoBzRpZVJOItSADXF9sTuL6UCdP5jtrEU
         gAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eMm0ezy8VT4lFNUlNPUxJVRZnEH3kBep31I7nhJwUA=;
        b=jufSG8e0bK+f+9XUPsvTmL+04AB36LQ0eXkXMnSEGBgmzyKXTbez5eBauc+UocylA7
         lYPe1AO5BQ7wOXpbQArNN1Mng88aLy5YgQkRoC8NKmlHRTSgp1QsxFq9xQT+7uBA6sW4
         Set+t0nuhGAIyAzVf7RREHzgv1RQbYwRXfMBIrWFx56utXU7bam3Ad9Fvhtypej/muMY
         V4EeaFci6flsUH9x+kYjHKh69snuRqESH63FWRdjWXTe6RVTn9U/F7LauTKJYZy8NeQB
         q+ZP5pOjTD+OPN+TWKnrxjy2A0rz0I69A5lnryxoTW0FMlJzkD0q5kVBT+uEhPza3S76
         IX/A==
X-Gm-Message-State: AOAM531FJPG5j41gLnf9+TCmXTS3J3CVRsffqvpZHnoU/ETs8wsG5Fyk
	X5AF7TcWshFNiVfAgBKmwCRQeAB6RDJFPmxE
X-Google-Smtp-Source: ABdhPJx2aqlsPNMGEI3qS+cV6Rf1B/ufixhyqi8Ht8ZUX+h530/BxZivazuMEbPs4VXJEqSKdtDipw==
X-Received: by 2002:aa7:d04a:: with SMTP id n10mr38729691edo.33.1622045315049;
        Wed, 26 May 2021 09:08:35 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RESEND] [PATCH 0/8] Please ignore: resending some patches for patchwork.kernel.org
Date: Wed, 26 May 2021 18:08:05 +0200
Message-Id: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed as at previous weekly meetings, we decided to move from
patchwork.ozlabs.org to patchwork.kernel.org for various reasons:

  https://lore.kernel.org/mptcp/84426992-d161-ce7a-28c2-c578f521a96a@tessares.net/T/#u
  https://lore.kernel.org/mptcp/a2ee322e-3a55-f392-c697-d96d8054937d@tessares.net/T/#u

Some "old" patches needs to be re-sent to be able to track them on the new
instance.

Here they are, unmodified.

Please ignore them! (except if some are no longer relevant and can be dropped)

Cheers,
Matt
-- 
2.31.1

