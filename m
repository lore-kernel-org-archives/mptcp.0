Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F46FA9
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 10:00:36 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so7142924a12.0
        for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692093634; x=1692698434;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JIHhKGLq9kYw80lI9JRwmvfdbRSIvtR1NIaGzF3K97E=;
        b=yOeOK9cczh9h07xjUBf69IxpRX0qAmEjJGyNJJ4hV9W2DFgbIWq/4a5Kn+r6KaU3Gm
         HZktqHybMIyW5KUcD0kSY9P42njV6UkiYYb66nYLmGZPzBjhb/B07m0jLYEvEBatVzpF
         XAPKfvygrxpw7GJdoCGh5/TAIhcjcEYxxLMTmJFuEtBtRR5uLd1qg8Adv+bdli+j84ub
         1rbSEzHrmSX+fanO6mNGIvDdS+lN/Nrhn70c5zWIbP1bAkd7sgMNWwOcyom/Hrn8VIL1
         QWHWfvx42YzPRPAMunL30h+A4puNn+1sybnRwGxBihl7TfDBfQAXxC+3526yGzfYEpg/
         ShaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692093634; x=1692698434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIHhKGLq9kYw80lI9JRwmvfdbRSIvtR1NIaGzF3K97E=;
        b=NQLm3i/unzbespZ7q/5+LrYPKOvkzA4h7BFIPnP3FtWmZcBvaAzzwjRnxNtP/sfx7t
         M8lttfw6Nq5NQwizLyeGAb7V7ImTPK4g/1og2TCFlWuX0BxPrzQDkNxdmqZPQRnqS0Rm
         ClFzMIB6WGKg3rk3OkS3K1WrEQ1OA8o2zKs0YRuar/6jkM/9WV0/Cs08ZsC7geEjq/NZ
         RxBAagHHTQsFdXeVoXLjPbAaRshfywdUfvfdg6KlipoXJJwEJ8W0NlfTnyDwUy4clItm
         QEdLCIkndcuHx+hCzXcy+oEX4uLWagIfmVUoU+XJDtggqBg8aOXJi5KdCygYGud5qMq6
         doFA==
X-Gm-Message-State: AOJu0Yy7iG1S9BDkHWUDFeAEShvSc5Xx6tvk6z46ttQBvmZmg8js/F/o
	YLeXwHDFXFKQ0ti4Gg2nxm88Vj95wLwQ9Iw+0L2y4nFKRUPd1imQO5o=
X-Google-Smtp-Source: AGHT+IHlTZOguQqSxwJ5+ovmf3I9OugFXwTguD+sI0TTMm3R9QHaZHFtwLBi2UZSyVduuod4UPRJz6rFvc1/tR/a91A=
X-Received: by 2002:a17:906:76d3:b0:99b:4fff:6bb with SMTP id
 q19-20020a17090676d300b0099b4fff06bbmr10321580ejn.4.1692093634398; Tue, 15
 Aug 2023 03:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 15 Aug 2023 12:00:00 +0200
Message-ID: <CAKuKrBkAiiwHsaTJKPfmmcRE8J4KdAF8qM1=EQX3tqGBmOuX=w@mail.gmail.com>
Subject: [Weekly meetings] no meeting today
To: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hello,

Just a reminder that there is no weekly meeting today.

Talk to you next week,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
