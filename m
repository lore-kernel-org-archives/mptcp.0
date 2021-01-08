Content-Type: multipart/mixed; boundary="===============4145414444521446807=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/9] ADD_ADDR: ports support
Date: Fri, 08 Jan 2021 15:19:03 -0800
Message-ID: <972f77ce-f994-53d6-fc70-7c692da97021@linux.intel.com>
In-Reply-To: cover.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7290

--===============4145414444521446807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 5 Jan 2021, Geliang Tang wrote:

> v9:
> - use queue_rcu_work to release the listening socket.
> - squash v8's patch 2 with patch 3.
> - add two new patches, "mptcp: drop unused skb in
> subflow_token_join_request" and "mptcp: add a new helper
> subflow_req_create_thmac"
>

Hi Geliang -

I'd like to make a request to make review easier: Please include in the =

cover letter the base commit where the patches apply successfully, or a =

reference to a public git repo showing the full commit history. It took =

some trial and error to figure out that this patch set only applied on top =

of the export branch with the "add-IPv4-mapped address support v4" patch =

set applied too.

For example, referencing the export tag from the mptcp_net-next repo (like =

export/20201217T083536) and the patch set name and revision for any =

prerequisite patch sets would really help.

Thanks!

--
Mat Martineau
Intel
--===============4145414444521446807==--
