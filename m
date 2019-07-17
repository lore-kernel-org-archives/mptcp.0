Content-Type: multipart/mixed; boundary="===============7153197425561920681=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] roadmap proposal/discussion
Date: Wed, 17 Jul 2019 19:00:59 +0200
Message-ID: <0220bc31c1297158107e87df9198635c2acdbb07.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1506

--===============7153197425561920681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I spent some time reviewing the current code-base looking for missing
pieces required for multiple subflow support, and I think there are a
bunch of things that would be needed no matter what.

I'd like to share the list, with some random implementation details, to
possibly avoid duplicate effort and/or large misunderstanding on my
side. Here it goes:

* Update msk data_ack:
  - hook in mptcp_attach_dss() - possibly rename the function to    =

      mptcp_data_ready()
  - cope with 32bit ack =

  - possibly some additional msk-level [spin-]lock would be required to
    protect from concurrent updates when multiple sub-flows are running
    - while at this, eventually re-consider (again!) conn_list
      locking ?!?

* Store in msk pending data, to allow retransmissions
  - in sendmsg(), queue pending (unacked) xmit msg on msk rtx_queue
    - does it need to be a rb tree?
      - sort by mptcp seq
        - cope with 32bit seq
  - allocate the node element from the msk page frag's allocator
    - each node must contains: all the data frag, mptcp seq, =

      [mptcp seq_end?]
  - NO need to check vs mptcp window before tcp_push()
        unless we want to update the window size as per RFC
          (max of subflow's window size)
        because msk ws is greater equal than subflows ws
  - free acked nodes (and data) still in sendmsg(),
    just after acquiring msk lock, before doing any real
    sendmsg related work

* Implement msk-level retransmission
  - add msk-level [hr-]timer
  - schedule it in sendmsg, after tcp_push()
    - e.g. if msk ack !=3D msk seq =

    - which timeout? subflow's rtt based ?
  - when the timer expires, trigger retransmit if msk ack is not
    changed (increased) since the timer's scheduling
    - reuse/factor-out part of current sendmsg_frag() retransmit
      a bunch of already-in-kernel page frags.

I hope the all above can be quite independent from e.g. path management
implementation.

If there is agreement on that, my plan would be to work on the listed
items, in order. As usual, any feedback more than welcome!

Thanks,

Paolo


--===============7153197425561920681==--
