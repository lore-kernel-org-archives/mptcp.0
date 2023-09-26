Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F112B70
	for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 10:01:05 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so21018740a12.0
        for <mptcp@lists.linux.dev>; Tue, 26 Sep 2023 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695722463; x=1696327263; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JIHhKGLq9kYw80lI9JRwmvfdbRSIvtR1NIaGzF3K97E=;
        b=qr3HIqe/z/yalrknL35me5UzDu4SgsPy//OxDcRCJYe4JVIVV3zIfqMi10x2FJr9f2
         6HETXgHJx4EXQU7sQRTsdYmXOC7qoCeBQQ0r2RV4ufGiPys8fqeeBdu9vxoBbC19fbLm
         asIf9iWrA47BflyVPJLFxjkQ3xXrRR4TD7ExN5Spxev87V/7lK4NQk24hrouTpmUg14g
         Qt1/f35eXQ8o7Bb1bdSmnePvKUorOQVZvkt0YKjS7nw6DRf4G1A31gsJvcUNwz0h7UrA
         tr0MmmubKHmpi5Oi5mEN8BM/WR1mk2/LNRevq1NfkXilh2D7dgx0PLYnKLkYvGHkqj2A
         oz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695722463; x=1696327263;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIHhKGLq9kYw80lI9JRwmvfdbRSIvtR1NIaGzF3K97E=;
        b=MY4T2IxkYIcfngjoS9ZaPBnJBcYrmf9iMHzI6p4hdAgTvECmVop83uNlc3HMe7lwfK
         4HmYdEfH5aqLJ4gs1kKsp+JFr/MVPVvuTLC7ESNOWwWE5601ce/jbBr2vmZ3siGCKdQx
         0wCHZh7cs/qX96Ew/T7pt0wuo3BQKTzGRtSPvyz2z8ijjYEkutDvILaNm5B4/+ISd6KA
         TcyGQYsRr/MhdKavHsodQrJOXWe5eDQuEHVqFunEVAfAOeT2pJobnjp8BhdmRMRXmLKL
         jUX8pqXNm2ahOHUE/EIoIByYQoXhRSfIlk7Z11r+rhSrjUUns+wDj0HvFfpSOlq6JrKk
         XZEQ==
X-Gm-Message-State: AOJu0YxKcDPeakK5yeB0uAlI9lPGABbOPZ+teg74/I+lKwsFxvJtMFRJ
	JMWB/uu4EYcLZ7RsToRqlvEaJQBjp1MnzH7IacbWpVbSVysH+9CElgohqHgw
X-Google-Smtp-Source: AGHT+IGy5i/nXuSo+gM+muXKzHUnWC02SDWkzTijiSiq2JSE4mdCz/NyJV+tGAMm43kEKEs0tAhR08ehvFLrbmPsdbk=
X-Received: by 2002:a17:907:7d9e:b0:9ad:8a96:ad55 with SMTP id
 oz30-20020a1709077d9e00b009ad8a96ad55mr3741390ejc.14.1695722463252; Tue, 26
 Sep 2023 03:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 26 Sep 2023 12:00:00 +0200
Message-ID: <CAKuKrBmKq0WLXU+YxohB4gn197UabboYaffE1jd=kQ7pyVD8cg@mail.gmail.com>
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
