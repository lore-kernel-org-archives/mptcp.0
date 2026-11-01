Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560892;
	b=i7vz5duTVDUQq1kmue+Qjj7v6hMK3WGyFQjE1jnEKIUmQNT2x/fze6eei+iSEjHFTa4V
	 pAFs8KoeWYaXtHX9QeI4mzdvlDIJ3CqFuPM7ZAeMnE+6v8hcXxpnkP/Ggo9ITR63I4mmF
	 8F5KiWBwsYbBaDSiU+A5gnI6w7f8q1uXzfJ2yzI7UdtNzzldPUA+edK6WuXdRJARb/3gP
	 o5X6HAPSMNyGFuME0vckd6uASOAy2GUEZd8kjAAv2I3z3gGmEqFtT1pElUAT1XDQxiPhX
	 htF4j9ECQ2ps1YLxKvlbYZHGWA4OzE5Jq3xA/AUiKQqL+zuRUtKY8IPN8mB/bu3kY3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=ACGf1HY3hF5Kcy0ZdTE967dKhzMAsJ+yzT2gnzwo/c8K4sz3yfzBpEe6LBWGiq6jKazL
	 GblGEHqExOrrvMWQcRM+Kuu18qnJMZU/zQtvmtXy/TZYKhxfDeLR/2uY6b1dzObdvf5pK
	 bPRnp93gZWl4JS7l13Kt12BZSGQna2+62Rx1NtG/zSKyeFa6aPaikES1+omngPcLYT4Vl
	 2keSmcaHsvaw9Tuj+BkdiUeGpxQyOiI4B5qQGU16Pyqh8rmoffK8aYcsQzy1cAThXBAdo
	 Ao/EU+4To9fMrPweXkq+qyXEICl9b9bJZoX+fFNQEahA7w1ftfkPqeCPKrWyXJDr9bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgFcT+PJ;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F70606A327
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F70606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgFcT+PJ
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eac4877accso7439805ad.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560892; x=1794165692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=ZgFcT+PJ+iTiGUiRI0fs4rBDaET/sd6TmqCRpgL9uRj4lGYr5KXg5NplfKjaGHzQLJ
         YVplyyJPdEHUFfeUJ19GegNRA3uC5pxEtvOQNmbdTHDEmT/ebGkXUYldY0ElPaoeBJRn
         sXNFoHZJJlEcY48YkyBqW34g3nYORqIHmcs0MAm1w6uv0UcDNdXRSPVdRka7f9smYKGx
         CHSQykL9k85JlNd0yWTehyBnF6rGi9+viaNemHMd82SCCGmPzr6GDE42NL7jeqlF8/kp
         nvWVRX6rNZQbUsQroFBwKjBJbM/bJSBRfX6gC0BZboVTrfnWUMYxc4VxWFASzIx5mGTF
         sLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560892; x=1794165692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=YLv8fs2Z+5kOvzCyZNv04zX7UUOlW4jN45GDgq5096oPPAEjh63eDbl4RYt2wtVoEB
         8v41J5zKCIdxK9f6xOUiiz9Z3XGUqacn+XmrElbqy4eaLEGAl/8Re8cDc0Ksfi+/cXat
         LwzLH5Qhv1wOFpCBuzuLwAh08XkxVP8dePSZYDXd8D9uBFURYnGntp4dzUPco0z/DJeU
         ALUH+RU24Ym2qXV/Ll1lUXapUvAC0645zeaYo2moZ1uP3CEnCcTEneYe53c1OVt/Kwdh
         OHEPSk3gpJ+O5L5IFLpdBE0dEb66hvZK406iq4VIBig59OmLQ9tEz3aMwBDoTOB+t1mm
         LOTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7TNqU3QM5sq2FsOc92MnDV5Afaprsqb0TKZvEm9t7JZU5jK94dNVDhwa/zsuH8oYgvB6lJw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1SzBVVlhWFi9t0zvV9tl5t+FKgBLr/ZUX6xfOpH6VmA8wqq7u
	T0vN48ZJMyRDkBc20jTuXNkLvWgNgUjItAOkrXe2ZuUPI5jx3zp7Ew5U
X-Gm-Gg: AYBFou1BD3UjNN9wfoP3wMWnGo9jRpgC9NBWufjDxLHuDoJ3lxGUfCHZonVMhizkx3E
	iEYbOcwJ2KULa+Yp5eaK8NrLW8ZpovBn1ZQDO0Z7CwpKI3FrtHO9BIAmLR4ywMvQmRmWhWZa/MP
	7BoSTKabgSvMm9lZSi6lzl6DzTno3rcxlyy2sPbaHQb5dInIFuU0NR1plC8WBsBpCm+kZYyVO2n
	+PPpjiZ5u/IbFXMOvpeWoi+p/A9YVfneDnenUfDESCNj6dSn8pd0yZMhrUaPYI+tixsPfDi/eNb
	2uk44wDOSyRF5Aszg0IdNVRHkCgJg0csQqP811ZVi3ScC4Ut+HERFRtfu5JK956pRLaZcQDuLmU
	6yu2VajJfKu81VH0LkbQGfJ3X7DtPS5hxthwoEy5Dqv+65ZBUbRlhxlXxA8t4HpGQ3hTW9dkJ9x
	zZziItFSBpnWxmaBOQtl/mHhjC7ULSBPygTevRhjw7nOvHa6oBl3b17gj2XvubE1M2SD5VRDvUs
	2YsCzgfsN49e+SGnP5qL2fM1qbRIlSYxvBN/YDrPQOtPe6xKCm4fxRq3qYAd+wJqxTjFzZSNmUs
	Hn1p76Up5chnFFy6pQaVa15/VJ5J0ypd6UPZuJOFwDfn9Pz9EWqC2FgAHL2sImmwWpejwVosBt5
	uM2CO7dy8klZ8SScgEpQao8Xo7JDffocbJ+oT2Tnx62wN2W13718KT1vFKbwvCHNHeXnn2mMYcV
	XoaNwvuDEM9/BY74mPWQDk
X-Received: by 2002:a17:903:38cc:b0:2e6:5ef:abe9 with SMTP id d9443c01a7336-2eb364b6332mr64259095ad.37.1793560891567;
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248621sm18975285ad.28.2026.11.01.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Sun,  1 Nov 2026 19:20:47 +0000
Message-ID: <20261101192057.2296489-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
the psock. When the socket has no room, the function saves the length and
offset of the remaining data in psock->work_state. A later run continues at
this offset and clears the state when the skb is complete.

sk_psock_skb_state() saves and clears the state, but only while
SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
each skb. If the socket closes during the loop, sk_psock_stop() clears the
flag. The loop continues, but the state of the completed skb stays. The
loop uses this state for all subsequent skbs and sends only part of their
data. A closing socket may lose the end of a stream, but not the middle.

The state belongs to the skb at the head of ingress_skb. Always clear the
state when this skb is complete. A stopped psock still saves no new state.

Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f03519468ad1..a5d498982848 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+	/* No new state once the psock is stopped, but never keep an old one */
+	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		state->len = len;
 		state->off = off;
 	}
-- 
2.55.0

