Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F3BA24
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671055350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FIfZDMz93+tMIUoDauhhPDBk4SBbL7tQwo8q9f07E80=;
	b=UBaBG2rBk/OwV4fNjQw4geSAnVW2/dKmKN2sbBCmE0PuRlY62tiCVK1Q9lr0hEXrdckAxz
	l/2j9Jr1yafviNm2hwiJflNU8Ga+7C5dn/TLdapYZm419u/zZ7eCtc4xbnlIDHJ4JwD63j
	ZQScrKfH6SJHXNCSvUulyfSj9+q5+YY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-GPs9MDT0Mk-sNta1mDZHBg-1; Wed, 14 Dec 2022 17:02:26 -0500
X-MC-Unique: GPs9MDT0Mk-sNta1mDZHBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE9D629A9D3F;
	Wed, 14 Dec 2022 22:02:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0B8D40C2064;
	Wed, 14 Dec 2022 22:02:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH 0/2] lsm: introduce and use security_mptcp_add_subflow()
Date: Wed, 14 Dec 2022 23:01:56 +0100
Message-Id: <cover.1671054577.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1

This series is an attempt to solve the LSM labeling breakage
reported here:

https://lore.kernel.org/linux-security-module/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/

As per previous discussion, a new LSM hook is introduced and
invoked by the mptcp code to let LSMs set the appropriate label
for the newly created subflow.

I'm not sure the chosen hook name is a perfect fit, any suggestion
more then welcome.
The new hook requires both the mptcp socket reference and the
subflow socket reference, even if the provided LSM implementation
for selinux ends-up accessing only the subflow socket. Possibly
other LSM implementation could need or use the addtional parameter.

Paolo Abeni (2):
  security, lsm: Introduce security_mptcp_add_subflow()
  selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/lsm_hooks.h     |  9 +++++++++
 include/linux/security.h      |  6 ++++++
 net/mptcp/subflow.c           |  6 ++++++
 security/security.c           |  5 +++++
 security/selinux/hooks.c      | 30 ++++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+)

-- 
2.38.1

