Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509932F9B
	for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 10:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=+Kn8y
	L6DCGwh8xO0v89VizarG5iA9jGRLbkHjnhSosY=; b=kSt6hkjN+6bPYiBA6f8Zj
	F2UnZpOi9YWNN0U3Gj4BylTR1sI2vh1BO4K71MH/PTs28C5wWWvcNCDYM2RU3+ej
	LTeFPRt2zyJrYjoOujOq1v1IpmOJBY9jxh+iYAGq/sPGIvdN89xyUSNvIARP0tc8
	W99cHscW9xH5mwCz/LLCKs=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp7 (Coremail) with SMTP id C8CowACXwZk5qH5gOBuvYA--.11157S2;
	Tue, 20 Apr 2021 18:08:58 +0800 (CST)
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: store remote token in mptcp sock
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 Florian Westphal <fw@strlen.de>, pabeni@redhat.com
Message-ID: <4e1d608e-4bcd-a432-03b7-860cd3e007c2@163.com>
Date: Tue, 20 Apr 2021 18:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowACXwZk5qH5gOBuvYA--.11157S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rurykKFW7XF45KF1xKrg_yoW5uw1DpF
	47Kw1rKwn5JF98J3WxJrWUZwnxWw1ftF90ka1293WxArsF9r9xJF1UGFW5A3yUWF4DtF9x
	XrW5XF1DJrn7uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b-FxUUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNxp6kFWBkIykQgAAsp

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Now every time create a new subflow, it needs to generate remote
token in __mptcp_subflow_connect(), the remote token is the same
among all subflows in a mptcp connection, so we can store
remote token in mptcp sock.

Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/protocol.c | 5 +++--
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 7 +++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a8180a9..607fb30 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2736,7 +2736,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	if (mp_opt->mp_capable) {
 		msk->can_ack = true;
 		msk->remote_key = mp_opt->sndr_key;
-		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+		mptcp_crypto_key_sha(msk->remote_key, &msk->remote_token, &ack_seq);
 		ack_seq++;
 		WRITE_ONCE(msk->ack_seq, ack_seq);
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
@@ -2967,7 +2967,7 @@ void mptcp_finish_connect(struct sock *ssk)

 	pr_debug("msk=%p, token=%u", sk, subflow->token);

-	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
+	mptcp_crypto_key_sha(subflow->remote_key, &subflow->remote_token, &ack_seq);
 	ack_seq++;
 	subflow->map_seq = ack_seq;
 	subflow->map_subflow_seq = 1;
@@ -2976,6 +2976,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	 * accessing the field below
 	 */
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->remote_token, subflow->remote_token);
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index edc0128..abd8e31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -226,6 +226,7 @@ struct mptcp_sock {
 	u64		wnd_end;
 	unsigned long	timer_ival;
 	u32		token;
+	u32		remote_token;
 	int		rmem_released;
 	unsigned long	flags;
 	bool		can_ack;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 82e91b0..ddd8c03 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1046,6 +1046,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				goto fatal;
 			}
 			WRITE_ONCE(msk->remote_key, subflow->remote_key);
+			mptcp_crypto_key_sha(READ_ONCE(msk->remote_key), &msk->remote_token, NULL);
 			WRITE_ONCE(msk->ack_seq, subflow->map_seq);
 			WRITE_ONCE(msk->can_ack, true);
 		}
@@ -1268,7 +1269,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	int local_id = loc->id;
 	struct socket *sf;
 	struct sock *ssk;
-	u32 remote_token;
 	int addrlen;
 	int err;

@@ -1308,10 +1308,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (err)
 		goto failed;

-	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
-		 remote_token, local_id, remote_id);
-	subflow->remote_token = remote_token;
+		 msk->remote_token, local_id, remote_id);
+	subflow->remote_token = msk->remote_token;
 	subflow->local_id = local_id;
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
-- 
1.8.3.1

