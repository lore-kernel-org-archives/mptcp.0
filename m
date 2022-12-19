Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6A6FB4
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 19:29:06 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id gh17so24040726ejb.6
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNhDl7b0fPeZNlPM/HqwudZ19bLRGX0k93mAt/dcKlY=;
        b=Itl8j+L6NJQi/HQ0wuksJ7WJ9VBGl5PK+lnpaGTdJQ8GBEuBrO+Mua3WPXQPUzygxB
         /9rTS2F/6LbIw380Jc943j4Iwu7De94EdEz25OUIkbZZWJ206I9lzinT9+pnimqdhO0z
         vlJxfcTRZe1jUtLKAPYdCJgwV1eCsFfHbc0iix8LICyrfk0Dzsdp3U8+5Ik9C3ujOUK3
         hfr22rziLqse4wuJBdL6xtEUAHKSRyx0fZwL+JGUUeGXJDeJLYgnSgni6lWV8G/9pnnO
         Akfkw9bs7+EgmnLwsoRSuPpszVKyy+8hmATqM9ogRB9e11BnqL1UkknGG+iJULT07uUD
         vk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNhDl7b0fPeZNlPM/HqwudZ19bLRGX0k93mAt/dcKlY=;
        b=Ee0iAyQi2Aorj5Fa3rnOjw2waiYfuuDLeS9BLSB+OT5UumU5Xqhjysbf8IAdt4Fk8i
         VhWaKqQVs5Rw9TcKYBpcK+T1Hbhro3QcIKUYbTzBeKoyFCDOr4xApx1TLY+oeMdoT3UQ
         fBCHVaVRTIbUOol8jGJiKuhcwhjOG9EpR6CjgCeC+rT4cEzJiejJchVJZDk6sSaMsEup
         1eUuxwSawaztKgZh+lEQ7f5Cjvvf1RZQU2Dz68n9k4ucDJ2GpozjyA/s1i2dWaLbStWa
         /uiRssbo28bhEHEeViXawDbiFTngOhCYGcbyGo55bwAfaRbZPezodKO2Onw+a89Lc/Fq
         NB+Q==
X-Gm-Message-State: AFqh2kr9qShRwtHVF85Jv0Harj7W1/7ixryUpuhDiQvlIX/MHIHmYsW9
	8LpVs3XstWWPxRCBn2hoWllGXxMqjLIViHJm
X-Google-Smtp-Source: AMrXdXvGKYQjGDFNzPSFHfT+eIje0MaWZnpsEbQNqGtBYuFC9/90RtY2bgw5gbpD3DuX6KJ7bAPr/g==
X-Received: by 2002:a17:906:4701:b0:7f9:f43e:2f06 with SMTP id y1-20020a170906470100b007f9f43e2f06mr11498694ejq.61.1671478144994;
        Mon, 19 Dec 2022 11:29:04 -0800 (PST)
Received: from [127.0.0.1] ([194.110.115.77])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906671600b007806c1474e1sm4684264ejp.127.2022.12.19.11.29.04
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 11:29:04 -0800 (PST)
Date: Mon, 19 Dec 2022 20:29:05 +0100 (GMT+01:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <661523e8-f174-4842-9894-659b2d1cd058@tessares.net>
Subject: [Weekly Meetings] Now each Tuesday
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <661523e8-f174-4842-9894-659b2d1cd058@tessares.net>

Hello,

As discussed last Thursday, the next weekly meeting is planned for tomorrow at 16.30 UTC: 17.30 in Central Europe, 8.30 on the West coast of the US.

Talk to you then!
Matt

PS: no meeting next week ;-)
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
