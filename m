Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF7EA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664358312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaB7lwIypQHYwQ94Njl42v5GFAZZooMQclLCS8RiQb4=;
	b=V4HDEUWgGIRNrJRbrH8PBmdc1mrNI6Nn2bhrGAkAYjXIbuZJPTQkd4pCVIqHjkS9ctf56m
	MlzIH6deyY1YrVqL8UbAWVhBjXYIZx3qPMOEsQBiwsSQJSsFKqD4h+j+3Gi1cStZBMABhA
	cTMeQG88r+xa+T9Zal7jQ6JPH+mFGYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-oFqIf9KFPzmENRRlKq58Nw-1; Wed, 28 Sep 2022 05:45:11 -0400
X-MC-Unique: oFqIf9KFPzmENRRlKq58Nw-1
Received: by mail-wm1-f70.google.com with SMTP id 62-20020a1c0241000000b003b4922046e5so6876645wmc.1
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=BaB7lwIypQHYwQ94Njl42v5GFAZZooMQclLCS8RiQb4=;
        b=kQXcoJxvjaz0IxyoEgoIMml05Xqsm9AyXbkKsAQJK7EZqHJHsunLzPo/iETzvDKyLK
         TDcRku4qeoZh2Jscz0SBJ0vAhk07tnGn5tEc5gewnlDG/v29tABmMkmiVldbvuzzYj/g
         8Mu2zGi+WVWZR6UdYhqcoDo2tZ8Dy7/GkgPfOKl20D9f3F4E+Qix0TJJt/A2dxcyek41
         qR4WKdVr3VI4tT6kVPY6rYVHpJTsxsdbsHOnPQBwJoMTIy6T3JVNggGbiN9pqTFwEQj0
         +IHVei1bhZesfgVV/feNTIL2cpokBfWJYFbQrjRNMEVsWcWIHcRpjaxpyJMIvhfzPGNj
         YYng==
X-Gm-Message-State: ACrzQf0okRaFuXwiFTgUf/q2fJS43Y8edvaBkx+WImHmOeZ51WxGaZTh
	7xhq+nHoX6SsB01bS6Gz7ZpJFO/nSqo1rTQhvEtNGUgUoiIU+Ik5+/a4xJYGP38gmLV2Bn6wZ20
	FJ+Wj5QqSjf2rS0k=
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id p21-20020a05600c359500b003b4837898d2mr6304956wmq.64.1664358310121;
        Wed, 28 Sep 2022 02:45:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5k0SPHwosm4cwZEc0RkAPZvhorr7wECY70L9/EczHoIXgnjrIYksWEblGqbBRapJBasd0wXA==
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id p21-20020a05600c359500b003b4837898d2mr6304943wmq.64.1664358309850;
        Wed, 28 Sep 2022 02:45:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c26d100b003a6125562e1sm1141767wmv.46.2022.09.28.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:45:09 -0700 (PDT)
Message-ID: <3ee71fb92a93914ab8c6bacc063731a1870d0a6e.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 7/7] selftests: mptfo
 initiator/listener
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 28 Sep 2022 11:45:08 +0200
In-Reply-To: <20220927225341.14165-8-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-8-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> MPTFO tests: these are examples of initiator (sendto) and listener,
> probably are going to be integrated to the mptcp_connect.* selftests
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

This must be integrated into the current self-tests suite:

- update the Makefile to build the helper program
  (or consider extending the exiting mptcp_connect program instead,
adding TCP_FASTOPEN support to the '-o' command line option)
- the script must be
  * listed in the Makefile TEST_PROGS
  * fully run the tests, executing the client and server program, 
    collecting the result and showing them in a clear way
  (or consider adding a new section to the mptcp_join.sh script
instead, see commit 5ac1d2d6345190907e260daedd980ab3be512cf0 for a
relevant example. You would need to use mptcp_connect to do this with a
reasonable amount of changes)

Additionally we need testcases for both sendmsg(MSG_FASTOPEN) and for
setsockopt(TCP_FASTOPEN), possibly in the positive (fastopen is
succesful) case and the negative one (switch to plain
connect/msg_fastopen fails).

/P

