Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D5290A
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 14:49:40 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso33925375e9.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687963779; x=1690555779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+/M9GSbZB3C/Kb53Q/D8d1eBmcCv58a0U2c0qVX5UI=;
        b=SFI2X5gLR1F1phz5ALDCvKpanPJV85NUyty1B29Ro7TlaUwzjBlg7uUQv0QjKiGgiP
         fsdTxIQIlt+vNO0DLBZFhDGjtq6kNLTfUlIXx14bKHybtGyBLXrC+Ow6fbtIAd7sjqLF
         LBlC3Kr9QtQQc5aBomW8rs/Enp/G7WXmK4PczHo0TNARjcIZxskfjah00Hilslnwf6eW
         vX9DxeXhX9vrV0HSMDJJ6Ku8zlGLmz7fxpHsbKQlDTtmlkUXz9X7G2cg2Bbn1AjZ2B+H
         FwkeEGSaZFgQUZuCdrdKXqYRChXrSMwqfPKyZDCSKSIkpGX1vzmnYGydeUVY8aVgUHSq
         /AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963779; x=1690555779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+/M9GSbZB3C/Kb53Q/D8d1eBmcCv58a0U2c0qVX5UI=;
        b=DZUpVfF5KWDdpLQgg1cvCtXa7ICRaqouM/B7NgJQ2kMEuA3pcaBzkVEe8fgCgzsOyS
         7bmtti3+ZT7BCE3azTnI4ndNOykzHw7V3FKWaYG7X6umXX/eHCVnz+YRxLkpFBPLcXwS
         pgD7ynBKnGtoQ00wn0ssgIWW6T2fn2/6d0QA/RmO8dB6fruA4JQoUj6GvIpO5fTX1+T1
         mh6lDYI5MNvlyNKTsy/HwBeygVqgQHuhAc5qMI81fNpaMNz2VLGGc/PHqR6LWsOCXl0S
         qz9fF9yfSikS2lKMt+IDTl5ib+imYF77QUxpv2ouxlVmu6XfVvAtqSSG6wrZh+Lloqh+
         435w==
X-Gm-Message-State: AC+VfDztyzxhS3m261VAEKGF72yYMfRguF6eFKc2mkqH7AiBf8+ROFdq
	ckA3AZxml253KpmLH1zlDck2ucyAZp0oc1J/4hW36Krl
X-Google-Smtp-Source: ACHHUZ5rQsH/sdwxpB5LIGKVy8SEjU1//fzX4NC7pyX/HQ/w0uZsuKSa27OAAnij6uNcKhO01gIa1A==
X-Received: by 2002:a5d:6950:0:b0:314:a30:62 with SMTP id r16-20020a5d6950000000b003140a300062mr2885915wrw.44.1687963778665;
        Wed, 28 Jun 2023 07:49:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b0030af15d7e41sm13713300wrm.4.2023.06.28.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:49:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: format subtests results in TAP (part 2)
Date: Wed, 28 Jun 2023 16:49:25 +0200
Message-Id: <20230628144927.828117-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=OBdQGSWEJdxlhHCIT6mAWPxjr79xhME78uH09IxifkE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBknEh3Maxv4A6refWNkGrS0CFGC7mwyRM6vE35d
 FPoWV6fKtCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJxIdwAKCRD2t4JPQmmg
 c45BD/0fybSLdwUxC+nZ5RGz9An+q4UgVj+8ExLoJ2Hx2MllY/o+EGuYVSv9A1oJacg4v1fXXUp
 p+eOg1NkDfjKyQteuaNZInMWhdtpMRV+r5c/HATurj/JFd7lO8iqJjmPcI3NzOHk3iXpDqoofV0
 xmBSWeuTUyp1HvpBHGTVfUocbxkeiC+ezxIJfc6kj3nscULb+jl8Do3C3Qu2CP6ymROSlKzBvHL
 KH6ygjHZ6cZBi6yhAoU+eTN9BnYPYY2z8OKEin9XiGqIzLjuljVafu302YuCWHuyKN8nISdf1Gm
 uDGtUkcJyfmeaTBwTsGehdOqE8j7pBXOvUcO80xl9lzKA8q70CduJB3iUkEdcB5C7S6FcRAUhQo
 Pku2C8g8/BHohtbkS4VLLo5lAVEuy81irS47lTpfnMVcWgwxl+C3jx3tuQWXkWWrudPA4GPAEUU
 lI0fkoa4y22ut2PLsqBuf6xAKjndu0tb06W24M3cZqF+Rm5Zo/GXVB5vqbKnDPbsIObnCt5B4m9
 vrIzwWSnr+N+nXKY65EaBjJegyu8nKA2CA2NtCw/0xOjhtDHg8AtA82NbPxzVni2n/+CI6y9zGo
 qp8uC52AH33FGfSFTeEO0xqXXWQeY29w0LpQ2p55ExriCpi51tZuWUAOZB21ufv61jxbMwqkb1t nskbYUmUQ3e0waA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Here are two more patches for the series "selftests: mptcp: format 
subtests results in TAP". As discussed at yesterday's meeting, it might
be good to print the test name earlier to avoid confusions when there is
an issue: sometimes the error is printed at the end of the previous test
and then the test name is printed. While at it, the code has been 
uniformed and it allows new features, e.g. colour support, see patch 2.

Matthieu Baerts (2):
  selftests: mptcp: join: rework detailed report
  selftests: mptcp: join: colored results

 .../testing/selftests/net/mptcp/mptcp_join.sh | 457 +++++++++---------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  38 ++
 2 files changed, 259 insertions(+), 236 deletions(-)

-- 
2.40.1

