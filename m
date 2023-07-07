Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686010795
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:27 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso22906225e9.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745625; x=1691337625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yh6oBVqskWJzBOIDn0CEm0aGOBWMTOnaXA2Ph/EdEI=;
        b=eN9LoreNOhhnWfu5Fisa6DVt2FgX2Ma9q38RtGhH5CVusZeZ8KiJL9msFSoPQDDVpC
         A+ljZtiu6nAIoNa9L5Nn8kJmkry3SrtQRd5VdpTLvcQcN1GEkE17W1x6nNK8che9FH6Y
         WYRWNGOyAIJXi22YbA3dI9tIFJlQBdhhC5GoRpA8pbw/ZHrdZefDmCz95+dPK/UmyLjp
         sxFq6a7eMbDIuYr7Sb2foQwENAto6DLQYijEkLfm3eWt8TAeH7ztfsXv1nZOAlqOuayH
         FpkGdWygx4Z+heyPRMPHvWgSUvImPtPOntf2FgjzKtRLuwWR2nA9xV3epajomgJRBA/y
         Ua/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745625; x=1691337625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yh6oBVqskWJzBOIDn0CEm0aGOBWMTOnaXA2Ph/EdEI=;
        b=M1GpNubVz3ugUHfipSxOZn1NZWXofs93LSEZO+Is2dlD5jDPxbi54fOpFWlsg+i1wi
         TUMXXDqZJ68ylwSUOJYLtqXdONrTa8Nm88HpaCiITJh7dMABAb3RJb8DdYIByZJO6Hah
         rS/OkQxYdHGSYXAVQRcl5Pfu/zHStI2T2VDBSmcPlGGrifDGCNpT/KwBuWeG8Sssh4j8
         JXjof840lKQBaPe3GQjoA5lswaH3WhJ02iqhcaY9qMoiNEsNUJISC6w9gyCyo+94frNO
         NUG4d+ztww1Cx1KOMVfwboqCMfMmX80OkRJw5/ZNEkwyeuNw6pKCcSw4NcUsM7bu5QN5
         MjcA==
X-Gm-Message-State: ABy/qLaN/hJxUq7CgMt6Oi22ujno3GB0yf0cXGvOHiADTgDjazjeTcWL
	obLy86HR0vVaX8VxSln6bS61SFI3rMg09QwM4re5Rw==
X-Google-Smtp-Source: APBJJlGOzrZjLTmd0+DHW5iGWouLaq9mQbhR+ZKhvKxJDrW+EUT5dzs9kKo15GP2XrAlUiphGlKVWA==
X-Received: by 2002:a1c:ed10:0:b0:3fb:b008:2002 with SMTP id l16-20020a1ced10000000b003fbb0082002mr4204004wmh.0.1688745624837;
        Fri, 07 Jul 2023 09:00:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:24 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/6] mptcp: sockopt: uniform code to get/set
 values
Date: Fri, 07 Jul 2023 18:00:10 +0200
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIo2qGQC/yXNQQ6CMBCF4auQWTuRtsLCqxgXbRlkYmibTkswh
 LsLuvzzku9tIJSZBO7NBpkWFo7hCHVpwE82vAh5OBp0q02rtcI5FZ+wBh4/KNG/YyrIIpXQdAa
 VHbre2d61N4LDcFYIXbbBT6dSrjVJyWTnc0yZRl5/5w/4u4HWAs99/wIBRanpmAAAAA==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hl8kG7spT5VUqKvzfAuRfcdhMWAmiaC2tihY/StGjT8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaXJuEYaymGnaKlA7SGDEDVUtfEPLTdzbG1X
 WngeERjezqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2lwAKCRD2t4JPQmmg
 cz8wEACSsKk6OyjeOZBBk/KcmRrYG8Z3x4KxWMqskjt6aBz81Ovp3bn1fA0jHjXfzb2YBNmUot2
 tbfRwL7zxyFirAcDc0Y0hvVSHNH0BEVkSYMGMRQQie01RNrbmRCBIecmBjHtWqDkHTw/XKNAibW
 yU0q9KMxdyGNfhD9ncCHrbtUTAoJ2B6uCQNadBCCYoA3A/NwFAxCiURTOVLJo2tEp4DWAauLNJF
 XYEvKjqX5Xb683YIRFr0Ui5y7UxYVhDvlqzAnhwMpPu8PgLNQVw9fknsHTozYeoG764OuPGFwoZ
 ZTceD1FEpcSJ7QyaLgkc2mtslG/JOCG6+BuCEFfbRVDayUR7WGsCPw70p5cLJ7cMHccjhO0CFvr
 A02BFi7+2qt7rUn8xL4HISYLHJu9wKMGYtV+Fw5AeA45Gqr+6AqYEQ9OhXMGiUaA563mr1/yum7
 RwYu1POl+uAC5hoWC4eY5KEA2uGv3gMI8MUvmpM8/CeffTPDbtzxjIYOmWH6+SoRkxY9pffWRq5
 wwSHk4Z36ILQmCblsaR3ELTdXFjN0zQeO9+K1yeOoimGg1yZQmKS+HoQUkNcuYh5IMTQBFB7uwd
 LsEq0X05YpoFGgV5a4smm4980DYe77xCH3P+7Z31rMUbSQHiDVkGHuAGeWVYUpB60jFIzqRu69s
 xkkPm2kFODnsWcw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is the implementation of an idea I suggested a few months ago: it
is a factoring of the sockopt code trying to uniform it, mainly to rely
on {ip,ipv6,tcp}_[gs]etsockopt() instead of copying what is done there
to get and set values.

That's a first step. More might come if we are OK with the approach,
e.g.

- For SOL_TCP socket options we cannot store info in the MPTCP socket so
  we still need to "manually" store it somewhere in the msk. Maybe we
  could store info in the different subflows (and create a first one if
  there is no subflow) and retrieve info from there?

- For SOL_SOCKET socket options, it looks like it should be feasible to
  do something similar to what I did here but I'm probably missing
  something. This could clean quite a lot of code, e.g. the last commit
  from:

    https://github.com/matttbe/mptcp_net-next/commits/b4/mptcp-unify-sockopt-issue-353

- To sync the socket options when a new subflow has been created, for
  the moment, we copy info from the msk to the subflow but maybe it
   would be fine to call some getsockopt() / setsockopt() to do the
  sync? If we take this approach, we might want to save a list of
  setsockopt() that have been done in the past on this socket and only
  re-do these ones? That should help with the maintenance of these
  socket options and ease the support of new ones.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (6):
      mptcp: sockopt: move tcp_inq code to a dedicated function
      mptcp: sockopt: update supported list
      mptcp: sockopt: get val in a generic way
      mptcp: sockopt: add missing getsockopt() options
      mptcp: sockopt: set val in a generic way
      mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS

 net/mptcp/sockopt.c | 241 ++++++++++++++++++++++++++--------------------------
 1 file changed, 121 insertions(+), 120 deletions(-)
---
base-commit: cde4fa6a0a5ed3effb75008ce99eb842bc448e5d
change-id: 20230221-mptcp-unify-sockopt-issue-353-1ad56ba6b04e

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

