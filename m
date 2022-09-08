Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F863322A
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:55 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id b17so12785476wrq.3
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=OUHDi113WkPzxKJeQlkeeITX3f75nt9KZZbA6x6lXo0=;
        b=IVihL0gs112uVfTDcOhrk+USq3GzzytxpbZ+QWTj79DX6MOSs10n9y2a1Dg9aYuP/3
         Xd/ScES4F/XwWCZnj0tolx0HOz1LIUVmg7lfdOCYBGuQ6TagVWV0NvSK1Cc0ztMM1rIc
         Fy5vIlJtvkC3HLF7aE1uxPqwV6timKxsfMZGCwUKlJ/uXt2GJ4i64MLV2bjV3idfwV4M
         HPipwm2CGIYCikyr0foLwAQqPJAPBrvR/cDzIGC3H1y17UrO9EExrWGgmrFbFauCo3iw
         nd5DEQCymUZVZeJ0iXAQVGpylmY9wequt4mPzaw0UidoW0+/ZyhGv1lNu/A0si/9BhwM
         5N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OUHDi113WkPzxKJeQlkeeITX3f75nt9KZZbA6x6lXo0=;
        b=HCm0C0WbdQjwwiAhtjF/bR+ABL0Kb11dJsXD7Z36ax7epGKPj8aK7ZOumyrRumzBt9
         B5Mu7L1MSHeKMVNUsW2HpLFOqa/0vCES0NVIhIU4DsuJt0CNAPShgJuVgeSJXeCvWa1x
         P2858C4+ga0Da8g1ruxeJbRKFHyUdCw6KGgrih4empe8Tc3AmVPb2yFIJNZoBFEFFFjD
         PSYjIjnghyw7Ly2d2JD/dnu7OterDVDg08XTHC3rCf+tEAugkmdBcNVoNu66yWZDZPmr
         erFLAa2YsROwSAFU5XeqBw2CC3Qx4IWnNo6IOJW9XgbFjmiyjVXqechwpctQBAEIF8gm
         BDLw==
X-Gm-Message-State: ACgBeo1UBQz8WQ5XHZHhehRgsqoR/KHQJnUUbN/VLDo6ItUVW4dj/QgC
	/UGv3bSzK4yXmWjYo1BqhY6qg7S4wPuIHhF0h7aKs9Etjod1yitXy62E4EB2meUYgNOijrrexMt
	xljjH3HmV/aCPb8YvYCGfwA==
X-Google-Smtp-Source: AA6agR4tRRuPqSoQzxlQlsNlQTQ/jkcjepFlNVWdDK7IyKcyUtFhRE4g8hfPJDMQ2ZLk1KjqQyTR0w==
X-Received: by 2002:a5d:6f0b:0:b0:226:458c:269 with SMTP id ay11-20020a5d6f0b000000b00226458c0269mr5127986wrb.223.1662644333356;
        Thu, 08 Sep 2022 06:38:53 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:53 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 10/10] mptcp: test TFO
Date: Thu,  8 Sep 2022 15:38:29 +0200
Message-Id: <20220908133829.3410092-11-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Work in progress for a future self test. Just for documentation, not
intended to be included as-is.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 tools/testing/selftests/net/mptcp/tfo.sh | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/tfo.sh

diff --git a/tools/testing/selftests/net/mptcp/tfo.sh b/tools/testing/selftests/net/mptcp/tfo.sh
new file mode 100755
index 000000000000..43440f80f92f
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/tfo.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+set -x
+
+DO_CLEANUP="${DO_CLEANUP:-1}"
+DO_MPTCPIZE="${DO_MPTCPIZE:-1}"
+
+cleanup() {
+	if [ "${DO_CLEANUP}" == "0" ]; then
+		return
+	fi
+
+	pkill tcpdump
+	pkill python
+
+	ip netns delete client
+	ip netns delete server
+}
+
+netns() {
+	ns="$1"
+	shift
+	ip netns exec "$ns" "$@"
+}
+
+
+trap cleanup EXIT
+
+ip netns add client
+ip netns add server
+
+netns client sysctl net.ipv4.tcp_fastopen=0x5
+netns server sysctl net.ipv4.tcp_fastopen=0x602
+
+netns client ip link add eth0 type veth peer eth0 netns server
+netns client ip addr add 6.6.6.1/24 dev eth0
+netns server ip addr add 6.6.6.6/24 dev eth0
+netns client ip link set eth0 up
+netns server ip link set eth0 up
+
+netns client tcpdump -i eth0 -w ./client.pcap &
+sleep 1
+
+if [ "${DO_MPTCPIZE}" == "0" ]; then
+	LD_PRELOAD=
+else
+	LD_PRELOAD="$PWD/mptcpize/libmptcpwrap.so"
+fi
+
+LD_PRELOAD=${LD_PRELOAD} netns server python3 -m http.server 666 &
+sleep 3
+
+LD_PRELOAD=${LD_PRELOAD} netns client curl --tcp-fastopen -o out.txt http://6.6.6.6:666/tfo.sh
+sleep 3
+
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


