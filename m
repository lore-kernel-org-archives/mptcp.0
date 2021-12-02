Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7A2C9D
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 17:32:33 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id a9so294208wrr.8
        for <mptcp@lists.linux.dev>; Thu, 02 Dec 2021 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/BitYW2MrWZriJVv66tEyAuB8x4wZE4++FO+/VB/1A=;
        b=B+NUls+DlijYXxMrWoZ9SdCvATu3Sn3DN6e1discK48Lo4qHyoSRl7dnPKAWFhgzXC
         MbWwoAVmj7MmkD/2BML8wOrRgWoPeKtNVLe4MfnJooe2wL8DXkdOoJ7VgBqaI105m9A4
         WV0hXyqy9lpRuEYG0CP/C33ZnRE8GLHEMZrsAlm5uVSKNcolCICOUAkVvx9Wr+Bj75JM
         f9JeXX3/869CeB5WFTZ7XtMv11ESAWmnr+Rc+pwHfrj7QK8AHMGi5Aou3Q90ccL0yMO7
         PDjaH0n1HCOFRxJjD2y0UrKtyhrjS8Cig/51Du/XmmbJXoBFG5xOFdBN3IQ6XIap4oNV
         BGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/BitYW2MrWZriJVv66tEyAuB8x4wZE4++FO+/VB/1A=;
        b=Z1Fn4fww3yYWkjDdKi8AAyE5a3cc/bCFXth9IKC//ycsKF2OgWQ7JJGdcAcLF3r4+U
         CQcFIJsAuXv5zhPt8twMnSeHEBmx7V68xep2D1lhCjPLukQUC/+7h6GES/4E5xdzGGyq
         EmfMG1DTXx+0vshvLrLXvszuBRsHbw1JRxhjrLlDehqPZyCxEQc0eO2qJaEZqUxS/8dQ
         9AbIPHUACgd40qIpbfImYcD9DC+p+rbHR8qWmlCyG5a2QqQU8jOty3IPRUGuXQcH1Bti
         KgnzYEgra5V+Z4ZL70ImiElDwptWmaLkfQ8ilT28si0fqm80wH5tT6FtExgOYIHwTNWS
         /sMQ==
X-Gm-Message-State: AOAM533dwWtzJEi61aWD1Pz2d7zn/btU/xNHUzRg9DdkQRZ9HGqNRR0V
	wjpyqflSDpEdBcr1/3hcATTI8NQ6KCY0+A==
X-Google-Smtp-Source: ABdhPJxMydJeGxtU8/NdKeF63ub5Ger5mqb6uOPij9b+WzRpkIUqkAjYcMJ+xWLSInuGn3VwsrOJAg==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr16157985wrt.453.1638466351286;
        Thu, 02 Dec 2021 09:32:31 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id v15sm417649wro.35.2021.12.02.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:32:30 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: check IP_TOS in/out are the same"
Date: Thu,  2 Dec 2021 18:32:15 +0100
Message-Id: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing a -Wunused-result error:

  $ make -C tools/testing/selftests/net/mptcp
  (...)
  gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    mptcp_sockopt.c  -o tools/testing/selftests/net/mptcp/mptcp_sockopt
  mptcp_sockopt.c: In function 'init_rng':
  mptcp_sockopt.c:695:9: warning: ignoring return value of 'read', declared with attribute warn_unused_result [-Wunused-result]
    695 |   (void)read(fd, &foo, sizeof(foo));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

It seems adding "(void)" is not enough. As a workaround, we can also
simply the output of 'read()'.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: check IP_TOS in/out are the same"

 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 5b87e162e704..ac9a4d9c1764 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -690,9 +690,11 @@ static void init_rng(void)
 
 	if (fd >= 0) {
 		unsigned int foo;
+		ssize_t ret;
 
 		/* can't fail */
-		(void)read(fd, &foo, sizeof(foo));
+		ret = read(fd, &foo, sizeof(foo));
+		assert(ret == sizeof(foo));
 
 		close(fd);
 		srand(foo);
-- 
2.32.0

