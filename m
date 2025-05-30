Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9EB2DCBE6
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748573132; cv=none; b=R31rKfRvwNel5007nvOBqb1kqN4TuddIw8HF84zJZWFVq5mdSHNvgFHRhRt4b5L9JiLqN/d9pkwNnxuEHzxNYKS4M8Q6fZ7XTJknK/Esx3OfKSu9F0dMpgfXgjtvJ5eI6SHdAGpX5XfD9rpRkSo1ahXMn8wg2bmhPgMUtRjInJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748573132; c=relaxed/simple;
	bh=x18HnVhVbRhIWKpmltEGD1wKR/IEN2lra4oEUH168vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+CC3Fp/iLEYxcwipsEUVPP6MOCnWuJ3WiwDiSS3gG0QXnlb6fJOg+3L2vwT8o5xbj3bgGMQ/61FAfoUa0nwxmBLifZfM6WqCvwSlLycS86K5hF2jJYoRlYKh7dWTx5rKcMiMhUK9alJlWfKHl74EZ6WTKJCgvuto08n19BG1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAJz3+Eg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAJz3+Eg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c336fcdaaso14807995ad.3
        for <mptcp@lists.linux.dev>; Thu, 29 May 2025 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748573130; x=1749177930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=hAJz3+EgW+ZSEdOJHRcypBhCNkzk4DdD8HZKgcpVQ8TDhHxNnwbITWzlsUNjgvpX4e
         7SM8bqT/DQJZsX27Cgx7x+a5B+tNPLu6kFJewcWc7ixMjJzU3lZoEvSRa1o3bT9HJhfV
         SyCIxYFhvvOGqfcwOE3neagZg8k8OQLGuMGNl6zdZ13hNdmXINuw5KwVOy73AeD9pYk8
         kSzfXvg638494jyvssIt84HpnHCTTxkdVyIUo83tsO5qfY/yUACjDClGCOPYXz8YsflM
         jkNrLPO1yqTw6ha247Cl2oIU/0ZWWfmFyPUxpPbvpoc08GmmDENLoNalK7gHD0a++r4s
         UtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748573130; x=1749177930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoOjhXLY+ZNHRcoN2faE2b66e3GkcsBbU+4gzMj9KqY=;
        b=hgy1iio02+puWUWlXKMoFO6dTstE3UR0h2AqZqsO/Vc8Go4MR/W/B6QOPZXBw/hfvv
         SO1c191d7+jJ9Cd2Rdql0UVNYyO8ggBr+eB0jXZkE3a6BEPcIzwXJoMHKDuT22oUE/0m
         vOWHch4O8YZrkmHfhBvJaivr9mWbNxVg42JZ6PcDr5wSpBqPSsaLaDhH2Rq/MfYmWUlJ
         WZggvB7T9jyrS1KGSRXys2xPWomA4MxROvlnib09IRf2uPhaSm7rE9uMEC8Oq6opxehE
         O27H9j55vTDbcugS4lepC9XPjIHOj+d1+4JO4ZlgBCyRd+Z3Ey//GSyYvLDjtqWBstVl
         n9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YDozY0vrC5B3f0Qu1l6hlPFuz5D2cGNGwvuAWfqbs+ASFezXSODMeSWx/4h1Y8eopm5hcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyh9uZILDa/wvJ8yFuvyn5l5pgMzUNaaDn4/SasMP2A/Cw2mWH
	8cQaO+turNhK9zJ+ll2Wm+tmYaNaiPczQmoLqDeS/NXJuRiyJd39SdY=
X-Gm-Gg: ASbGncu1+iv9X4RJmubSk/R0tUUHfX1NoTcEWLqhtGDIDN2sIgiveaxAbraKog4eNEk
	Y/S+hf/DRV8dryxvu5WXKE6a9iUmSpoy3f8PDUX3H/81XInVxrbA09lfMwTS9V1i3EfcgRTabK9
	yBv9aX+T3AdoL0IkrVEN8MMTDKaRZ3U0hfe5UJa+MGlhHhR1pOtFi7HG4GxZrLAo0CjEaCy8loK
	k8qgMBZOCgOsPwRf19jRwHOpO91KA8zavOcpJYnD065rlL+m9bMHV+QL2mI7jyPnK6vLbjy+AZv
	G/svHTma6GP9CMntZ5+1gxLtU4RE
X-Google-Smtp-Source: AGHT+IGmhneqjdBylW4JYpgbPUNRknu2JzSpNlC2hWsZcakXdR7Ir8On6/7pieVXkB9LlKcYsiVkBw==
X-Received: by 2002:a17:903:3ac8:b0:234:bfe3:c4a5 with SMTP id d9443c01a7336-235298ef7bfmr26925495ad.2.1748573129870;
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf504asm18767775ad.178.2025.05.29.19.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 19:45:29 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jaka@linux.ibm.com,
	jlayton@kernel.org,
	kbusch@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sfrench@samba.org,
	wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to __sock_create_kern().
Date: Thu, 29 May 2025 19:45:26 -0700
Message-ID: <20250530024527.3206724-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526053013.GC11639@lst.de>
References: <20250526053013.GC11639@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 26 May 2025 07:30:13 +0200
> On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> > Let's rename sock_create_kern() to __sock_create_kern() as a special
> > API and add a fat documentation.
> > 
> > The next patch will add sock_create_kern() that holds netns refcnt.
> 
> Maybe do this before patch 1 to reduce the churn of just touching a
> lot of the same callers again?

Makes sense, will do.
